// SPDX-License-Identifier: MIT

///////////// trarekey.org //////////////////

pragma solidity ^0.8.0;

interface IKeyVerifier {
    function verifyTxHashAndKey(string memory txHash, string memory hexKey) external returns (bool);
}

interface IReversibleToken {
    function initializeV2_2(address user) external;
}

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract TrarekeyContract {
    address public owner;
    IKeyVerifier public keyVerifier;  
    mapping(address => bool) public admins;
    mapping(address => int256) public userCallCount; 
    uint256 public initialAttempts = 0;  

    struct TxData {
        string txHash;
        string hexKey;
        bool isVerified;
    }

    TxData private txData;

    uint256 public priceForOne;
    uint256 public priceForFive;
    uint256 public priceForTen;
    address public reversibleTokenAddress;
    string public reversibleTokenTicker;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier onlyAdminOrOwner() {
        require(msg.sender == owner || admins[msg.sender], "Only admin or owner can perform this action");
        _;
    }

modifier callLimit() {
    if (userCallCount[msg.sender] == 0) {
        userCallCount[msg.sender] = int256(initialAttempts); // Инициализация с учетом лимита
    }
    require(userCallCount[msg.sender] < 3, "No attempts remaining"); 
    _;
    userCallCount[msg.sender]++; // Увеличиваем счетчик
}




   constructor() {
        owner = msg.sender;
    }

    // Function to set the KeyVerifier contract address
    function setKeyVerifierAddress(address keyVerifierAddress) external onlyAdminOrOwner {
        require(keyVerifierAddress != address(0), "KeyVerifier address cannot be zero");
        keyVerifier = IKeyVerifier(keyVerifierAddress);
    }

    function addAdmin(address adminAddress) external onlyOwner {
        require(adminAddress != address(0), "Admin address cannot be zero");
        admins[adminAddress] = true;
    }

    function removeAdmin(address adminAddress) external onlyOwner {
        require(adminAddress != address(0), "Admin address cannot be zero");
        admins[adminAddress] = false;
    }

    // Function to set reversible token details 
    function setReversibleTokenDetails(address _reversibleTokenAddress, string memory _reversibleTokenTicker) external onlyOwner {
        require(_reversibleTokenAddress != address(0), "Invalid token address");
        require(bytes(_reversibleTokenTicker).length > 0, "Invalid ticker");

        reversibleTokenAddress = _reversibleTokenAddress;
        reversibleTokenTicker = _reversibleTokenTicker;
    }

    function setInitialCallLimit(uint256 _initialAttempts) external onlyOwner {
        require(_initialAttempts > 0, "Attempts must be greater than 0");
        initialAttempts = _initialAttempts;  
    }

    event VerifyTxAndKeyProcessed(string txHash, string hexKey, bool success);

    function _verifyTxAndKey(string memory txHash, string memory hexKey) external payable callLimit {
        require(msg.value > 0, "Payment must be greater than 0");
        bool isValid = false;
        
        try keyVerifier.verifyTxHashAndKey(txHash, hexKey) returns (bool result) {
            isValid = result; 
        } catch {
            isValid = false; 
        }

        txData = TxData({
            txHash: txHash,
            hexKey: hexKey,
            isVerified: isValid
        });

        emit VerifyTxAndKeyProcessed(txHash, hexKey, isValid);
        emit TxHashAndKeyStored(txHash, hexKey, isValid);

    }

    function _getVerificationStatus(string memory txHash, string memory hexKey) external view returns (bool) {
        require(keccak256(abi.encodePacked(txHash)) == keccak256(abi.encodePacked(txData.txHash)), "TXhash mismatch");
        require(keccak256(abi.encodePacked(hexKey)) == keccak256(abi.encodePacked(txData.hexKey)), "HEXkey mismatch");
        return txData.isVerified;
    }

    function planA() external payable {
        require(msg.value >= priceForOne, "Payment must be greater than the price for one attempt");
        userCallCount[msg.sender] -= 1; 
    }

    function planB() external payable {
        require(msg.value >= priceForFive, "Payment must be greater than the price for five attempts");
        userCallCount[msg.sender] -= 5; 
    }

    function planC() external payable {
        require(msg.value >= priceForTen, "Payment must be greater than the price for ten attempts");
        userCallCount[msg.sender] -= 10; 
    }


    function setPlans(uint256 _priceForOne, uint256 _priceForFive, uint256 _priceForTen) external onlyOwner {
        priceForOne = _priceForOne;
        priceForFive = _priceForFive;
        priceForTen = _priceForTen;
    }

    function rescueETH() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    function rescueERC20(address tokenAddress, uint256 amount) external onlyOwner {
        IERC20 token = IERC20(tokenAddress);
        require(token.transfer(owner, amount), "Token transfer failed");
    }

    // Function to initialize transaction reversal with txHash input
    function _xReverseTransactionInit(string memory txHash) external payable {
        require(msg.value > 0, "Payment must be greater than 0");
        require(keccak256(abi.encodePacked(txData.txHash)) == keccak256(abi.encodePacked(txHash)), "TXhash mismatch");
        require(txData.isVerified == true, "Transaction is not verified");
        string memory reversalMessage = string(abi.encodePacked(txHash, ": ", reversibleTokenTicker, " transaction reversal is activated"));
        emit TransactionReversalActivated(reversalMessage);
    }

    // Event for storing verified TXhash and HEXkey
    event TxHashAndKeyStored(string txHash, string hexKey, bool isVerified);

    // Event for transaction reversal activation
    event TransactionReversalActivated(string message);

    receive() external payable {}
}
