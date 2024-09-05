// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Healthcare {

    struct PatientDataHash {
        string patientID;
        bytes32 dataHash;
        uint256 timestamp;
    }

    mapping(string => PatientDataHash) public patientData;

    event DataStored(string indexed patientID, bytes32 dataHash, uint256 timestamp);

    function storeDataHash(string memory patientID, bytes32 dataHash) public {
        PatientDataHash memory newData = PatientDataHash({
            patientID: patientID,
            dataHash: dataHash,
            timestamp: block.timestamp
        });

        patientData[patientID] = newData;

        emit DataStored(patientID, dataHash, block.timestamp);
    }

    function getDataHash(string memory patientID) public view returns (bytes32, uint256) {
        return (patientData[patientID].dataHash, patientData[patientID].timestamp);
    }
}
