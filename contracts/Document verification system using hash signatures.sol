// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DocumentVerificationSystem {
    struct Document {
        address uploader;
        uint256 timestamp;
        bool verified;
    }

    mapping(bytes32 => Document) public documents;

    event DocumentUploaded(bytes32 indexed docHash, address indexed uploader, uint256 timestamp);
    event DocumentVerified(bytes32 indexed docHash, address indexed verifier);

    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Upload a new document hash
    function uploadDocument(bytes32 docHash) external {
        require(documents[docHash].timestamp == 0, "Document already uploaded");

        documents[docHash] = Document({
            uploader: msg.sender,
            timestamp: block.timestamp,
            verified: false
        });

        emit DocumentUploaded(docHash, msg.sender, block.timestamp);
    }

    // Owner verifies a document
    function verifyDocument(bytes32 docHash) external onlyOwner {
        require(documents[docHash].timestamp != 0, "Document not found");
        require(!documents[docHash].verified, "Document already verified");

        documents[docHash].verified = true;

        emit DocumentVerified(docHash, msg.sender);
    }

    // Check if a document hash is verified
    function isVerified(bytes32 docHash) external view returns (bool) {
        return documents[docHash].verified;
    }

    // Get document details
    function getDocument(bytes32 docHash) external view returns (address uploader, uint256 timestamp, bool verified) {
        Document memory doc = documents[docHash];
        require(doc.timestamp != 0, "Document not found");
        return (doc.uploader, doc.timestamp, doc.verified);
    }
}
