// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract LandRegistry {
    // Struct to store land details
    struct Land {
        string ownerName;
        string landTitle;
        string location;
        uint256 area; 
        uint256 landId; 
        address registeredBy; 
        bool exists; 
    }
    mapping(uint256 => Land) public landRecords;
    uint256 public landCount = 0;
    event LandRegistered(
        uint256 indexed landId,
        string ownerName,
        string landTitle,
        string location,
        uint256 area,
        address indexed registeredBy
    );
    modifier landNotExists(uint256 _landId) {
        require(!landRecords[_landId].exists, "Land ID already registered");
        _;
    }
    function registerLand(
        string memory _ownerName,
        string memory _landTitle,
        string memory _location,
        uint256 _area
    ) public returns (uint256) {
        landCount++;
        Land memory newLand = Land({
            ownerName: _ownerName,
            landTitle: _landTitle,
            location: _location,
            area: _area,
            landId: landCount,
            registeredBy: msg.sender,
            exists: true
        });
        landRecords[landCount] = newLand;
        emit LandRegistered(
            landCount,
            _ownerName,
            _landTitle,
            _location,
            _area,
            msg.sender
        );
        return landCount;
    }
    function getLandDetails(uint256 _landId) 
        public 
        view 
        returns (
            string memory ownerName,
            string memory landTitle,
            string memory location,
            uint256 area,
            address registeredBy
        ) 
    {
        require(landRecords[_landId].exists, "Land ID does not exist");
        Land memory land = landRecords[_landId];
        return (
            land.ownerName,
            land.landTitle,
            land.location,
            land.area,
            land.registeredBy
        );
    }
}
