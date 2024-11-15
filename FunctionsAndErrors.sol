// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FunctionsAndErrors {
    struct healthData {
        string name;
        uint distance; // km
        uint carbs; //gm
        uint steps;
        uint sex; // 1 male, 2 female
        uint age;
    }

    mapping(address => healthData) private healthRecords;

    function setUser(string memory _name, uint _sex, uint _age) public {
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(_sex > 0 && _sex < 3, "Sex must be only 1 for Male, and 2 for Female");
        require(_age > 17, "You must be 18 years old and above");
        healthRecords[msg.sender].name = _name;
        healthRecords[msg.sender].sex = _sex;
        healthRecords[msg.sender].age = _age;
    }

    function logDistance(uint _distance) public {
        require(_distance > 0, "Distance must be greater than 0 kilometers");
        
        uint previousDistance = healthRecords[msg.sender].distance;
        healthRecords[msg.sender].distance += _distance;

        assert(healthRecords[msg.sender].distance == previousDistance + _distance);
    }

    function logCarbs(uint _carbs) public {
        require(_carbs > 0, "Carbohydrate intake must be greater than 0 grams");

        uint previousCarbs = healthRecords[msg.sender].carbs;
        healthRecords[msg.sender].carbs += _carbs;

        assert(healthRecords[msg.sender].carbs == previousCarbs + _carbs);
    }

    function logSteps(uint _steps) public {
        require(_steps > 0, "Steps must be greater than 0");

        uint previousSteps = healthRecords[msg.sender].steps;
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

    function calcWeightLost(uint _walkTime, uint _weight) public view returns (uint, uint ) {
        require(_walkTime > 0, "Walk time must be greater than 0 minutes");
        require(_weight > 0, "Weight must be greater than 0 kilograms");

        uint MET = (healthRecords[msg.sender].sex == 1) ? 4 : 3; 
        uint minutesInHour = 60;
        uint kcalPerKg = 7700;

        uint durationInHours = _walkTime / minutesInHour;

        uint calories = MET * _weight * durationInHours;

        uint gramsLost = (calories * 1000) / kcalPerKg;

        return (calories, gramsLost);
    }
}
