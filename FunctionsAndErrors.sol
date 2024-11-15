// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FunctionsAndErrors {
    struct healthData {
        string name;
        uint distance; // km
        uint carbs; //gm
        uint steps;
    }

    mapping(address => healthData) private healthRecords;

    function setName(string memory _name) public {
        require(bytes(_name).length > 0, "Name cannot be empty");
        healthRecords[msg.sender].name = _name;
    }

    function logDistance(uint _distance) public {
        require(_distance > 0, "Distance must be greater than 0 kilometers");
        
        uint256 previousDistance = healthRecords[msg.sender].distance;
        healthRecords[msg.sender].distance += _distance;

        assert(healthRecords[msg.sender].distance == previousDistance + _distance);
    }

    function logCarbs(uint256 _carbs) public {
        require(_carbs > 0, "Carbohydrate intake must be greater than 0 grams");

        uint256 previousCarbs = healthRecords[msg.sender].carbs;
        healthRecords[msg.sender].carbs += _carbs;

        assert(healthRecords[msg.sender].carbs == previousCarbs + _carbs);
    }

    function logSteps(uint256 _steps) public {
        require(_steps > 0, "Steps must be greater than 0");

        uint256 previousSteps = healthRecords[msg.sender].steps;
        healthRecords[msg.sender].steps += _steps;

        assert(healthRecords[msg.sender].steps == previousSteps + _steps);
    }

    function resetHealthRecord() public {
        healthData storage data = healthRecords[msg.sender];

        if (data.distance == 0 && data.carbs == 0 && data.steps == 0) {
            revert("Records are already reset.");
        }

        data.distance = 0;
        data.carbs = 0;
        data.steps = 0;
    }

    function getHealthRecord() public view returns (string memory, uint, uint, uint) {
        healthData memory data = healthRecords[msg.sender];
        return (data.name, data.distance, data.carbs, data.steps);
    }
}
