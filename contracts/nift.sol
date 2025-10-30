
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract CertificateIssuer is ERC721, AccessControl {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    bytes32 public constant ISSUER_ROLE = keccak256("ISSUER_ROLE");
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    struct Certificate {
        address issuer;
        address subject;
        bytes32 dataHash;
        uint256 issuedAt;
        bool revoked;
    }

    mapping(uint256 => Certificate) private _certificates;

    event CertificateIssued(
        uint256 indexed tokenId,
        address indexed issuer,
        address indexed subject,
        bytes32 dataHash,
        uint256 issuedAt
    );

    event CertificateRevoked(uint256 indexed tokenId, address indexed revokedBy, uint256 revokedAt);
    event CertificateUnrevoked(uint256 indexed tokenId, address indexed unrevokedBy, uint256 time);

    constructor(
        string memory name_,
        string memory symbol_,
        address admin
    ) ERC721(name_, symbol_) {
        require(admin != address(0), "Admin cannot be zero address");

        // ✅ Use _grantRole instead of _setupRole for OpenZeppelin v5+
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(ADMIN_ROLE, admin);
        _grantRole(ISSUER_ROLE, admin);
    }

    function issueCertificate(address subject, bytes32 dataHash)
        external
        onlyRole(ISSUER_ROLE)
        returns (uint256 tokenId)
    {
        require(subject != address(0), "Invalid subject address");
        require(dataHash != bytes32(0), "Invalid data hash");

        _tokenIdCounter.increment();
        tokenId = _tokenIdCounter.current();

        _safeMint(subject, tokenId);

        _certificates[tokenId] = Certificate({
            issuer: msg.sender,
            subject: subject,
            dataHash: dataHash,
            issuedAt: block.timestamp,
            revoked: false
        });

        emit CertificateIssued(tokenId, msg.sender, subject, dataHash, block.timestamp);
    }

    function revokeCertificate(uint256 tokenId) external {
        Certificate storage cert = _certificates[tokenId];
        require(cert.issuedAt != 0, "Certificate does not exist");
        require(!cert.revoked, "Already revoked");
        require(
            hasRole(ADMIN_ROLE, msg.sender) || msg.sender == cert.issuer,
            "Not authorized"
        );

        cert.revoked = true;
        emit CertificateRevoked(tokenId, msg.sender, block.timestamp);
    }

    function unRevokeCertificate(uint256 tokenId) external onlyRole(ADMIN_ROLE) {
        Certificate storage cert = _certificates[tokenId];
        require(cert.issuedAt != 0, "Certificate does not exist");
        require(cert.revoked, "Certificate not revoked");

        cert.revoked = false;
        emit CertificateUnrevoked(tokenId, msg.sender, block.timestamp);
    }

    function getCertificate(uint256 tokenId)
        external
        view
        returns (
            address issuer,
            address subject,
            bytes32 dataHash,
            uint256 issuedAt,
            bool revoked
        )
    {
        Certificate memory cert = _certificates[tokenId];
        require(cert.issuedAt != 0, "Certificate does not exist");
        return (cert.issuer, cert.subject, cert.dataHash, cert.issuedAt, cert.revoked);
    }

    function verifyCertificate(uint256 tokenId, bytes32 providedDataHash)
        external
        view
        returns (
            bool isValid,
            address issuer,
            address subject,
            uint256 issuedAt,
            bool revoked
        )
    {
        Certificate memory cert = _certificates[tokenId];
        if (cert.issuedAt == 0) {
            return (false, address(0), address(0), 0, false);
        }

        bool matches = (cert.dataHash == providedDataHash);
        bool valid = matches && !cert.revoked;
        return (valid, cert.issuer, cert.subject, cert.issuedAt, cert.revoked);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
