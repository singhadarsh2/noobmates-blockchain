// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HealthcareIdentifierManagement {

    // Structure to store the identifiers
    struct Identifier {
        string patientID;
        string schemeID;
        string hospitalID;
        address createdBy; // Address of the entity that created this record
        uint256 timestamp; // Timestamp when the record was created
    }

    // Mapping to store identifiers against a unique ID
    mapping(bytes32 => Identifier) private identifiers;

    // Event to be emitted when a new identifier is added
    event IdentifierAdded(bytes32 indexed recordHash, string patientID, string schemeID, string hospitalID, address createdBy, uint256 timestamp);

    // Function to add a new identifier to the blockchain
    function addIdentifier(string memory patientID, string memory schemeID, string memory hospitalID) public {
        // Create a unique hash for the record
        bytes32 recordHash = keccak256(abi.encodePacked(patientID, schemeID, hospitalID, block.timestamp));

        // Store the identifier in the mapping
        identifiers[recordHash] = Identifier({
            patientID: patientID,
            schemeID: schemeID,
            hospitalID: hospitalID,
            createdBy: msg.sender,
            timestamp: block.timestamp
        });

        // Emit an event when the identifier is added
        emit IdentifierAdded(recordHash, patientID, schemeID, hospitalID, msg.sender, block.timestamp);
    }

    // Function to retrieve an identifier by its hash
    function getIdentifier(bytes32 recordHash) public view returns (string memory, string memory, string memory, address, uint256) {
        Identifier memory id = identifiers[recordHash];
        require(bytes(id.patientID).length > 0, "Identifier not found");

        return (id.patientID, id.schemeID, id.hospitalID, id.createdBy, id.timestamp);
    }
}
