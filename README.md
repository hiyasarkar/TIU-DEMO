
# 🧾 Certificate Issuer Smart Contract
![Uploading image.png…]()

A **blockchain-based certificate management system** that allows trusted issuers to issue, revoke, and verify certificates securely on-chain. This project is built using **Solidity** and leverages **OpenZeppelin’s AccessControl** and **ERC721** standards to make certificates verifiable and tamper-proof.

---

## 📘 Project Description

This project demonstrates how certificates (like academic credentials, licenses, or digital achievements) can be represented as **NFTs (ERC721 tokens)**.
Each certificate is linked to a data hash, making it possible to verify authenticity and integrity.

It is designed for organizations or individuals who want to:
✅ Issue verifiable certificates.
✅ Revoke or restore them if needed.
✅ Enable anyone to verify a certificate’s authenticity.

---

## ⚙️ What It Does

* Allows **authorized issuers** to create and issue blockchain certificates.
* Stores **certificate metadata** (issuer, subject, data hash, issue date, and revocation status).
* Enables **certificate verification** by comparing stored hashes.
* Provides **revocation control** to issuers and admins.
* Uses **role-based access control (RBAC)** for secure certificate management.

---

## 🌟 Features

### 🔐 Role-Based Access

* **ADMIN_ROLE:** Can manage roles and un-revoke certificates.
* **ISSUER_ROLE:** Can issue and revoke certificates.
* **DEFAULT_ADMIN_ROLE:** Has all permissions.

### 🪪 Certificate Management

* **Issue Certificates:** Mint a new NFT certificate tied to the recipient.
* **Revoke Certificates:** Temporarily invalidate a certificate.
* **Unrevoke Certificates:** Restore revoked certificates.
* **Verify Certificates:** Validate if the provided hash matches the blockchain data.

### 🧱 Built With

* **Solidity v0.8.19**
* **OpenZeppelin Contracts**
* **AccessControl & ERC721 Standards**
* **Celo Alfajores Testnet**

---

## 🚀 Deployed Smart Contract

🔗 **Network:** Celo Alfajores Testnet
📍 **Contract Address:** [0xC9905BbCBe55880E0210b529336Cd6eE74b95f67](https://celo-alfajores.blockscout.com/address/0xC9905BbCBe55880E0210b529336Cd6eE74b95f67)

🧩 **Deployed Smart Contract Link:** XXX

---

## 💻 Smart Contract Code

```solidity
//paste your code
```

---

## 🧠 How It Works

1. **Admin Setup:**
   The deployer or specified admin receives all roles initially.

2. **Issuing a Certificate:**
   The issuer calls `issueCertificate(subject, dataHash)` to mint a new certificate NFT.

3. **Revoking a Certificate:**
   The issuer or admin calls `revokeCertificate(tokenId)` to mark it as revoked.

4. **Unrevoking a Certificate:**
   The admin can restore a revoked certificate with `unRevokeCertificate(tokenId)`.

5. **Verifying a Certificate:**
   Anyone can call `verifyCertificate(tokenId, providedDataHash)` to confirm authenticity.

---

## 🧩 Example Use Cases

* 🎓 Universities issuing digital diplomas
* 🧑‍💻 Companies providing verifiable training certificates
* 🧾 Government-issued licenses or permits
* 🏅 NFT-based digital achievements

---

## 🛠️ Installation (Optional for Developers)

If you want to deploy or test locally:

```bash
git clone https://github.com/yourusername/CertificateIssuer.git
cd CertificateIssuer
npm install
```

Compile the smart contract:

```bash
npx hardhat compile
```

Deploy to a test network:

```bash
npx hardhat run scripts/deploy.js --network alfajores
```

---

## 📜 License

This project is licensed under the **MIT License**.
Feel free to use, modify, and build upon it.

---

## ✨ Author

👩‍💻 **Hiya Sarkar**
📫 [Your GitHub Profile](https://github.com/hiyasarkar)

---

