# FunctionsAndErrors - A Metacrafters Project for ETH + AVAX Proof

This project is a simple Health Monitoring contract that demonstrates the use of `require()`, `assert()`, and `revert()` statements.

## Description

The project simulates a personal health monitoring system on the Ethereum blockchain. Users can:
- Log their distance traveled (in kilometers).
- Record carbohydrate intake (in grams).
- Track steps taken.
- Retrieve and reset their health records.

The contract includes checks to ensure valid data input and the integrity of the stored health data.

## Getting Started

### Installing

1. Install [Node.js](https://nodejs.org)

   Download and install from the official site.

2. Install [Truffle](https://github.com/trufflesuite/truffle)

   ```bash
   npm install -g truffle
   ```

### Executing Program

To run this program, use the Gitpod tools provided by Metacrafters or any local blockchain development environment.

## Initialize

1. Initialize Truffle in your project folder:

   ```bash
   truffle init
   ```

   After initialization, you will find two folders: `contracts` for your Solidity files and `migrations` for deployment settings.

2. The "FunctionsAndErrors" contract

   "FunctionsAndErrors.sol" in `contracts` contains the following code:

   ```solidity
   // SPDX-License-Identifier: MIT
   pragma solidity ^0.8.18;

   contract FunctionsAndErrors {
       struct healthData {
           string name;
           uint distance; // km
           uint carbs; // gm
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
   ```

3. Prepare the Migration

   Create "2_deploy_functions_and_errors.js" in `migrations` with the following code:

   ```javascript
   const FunctionsAndErrors = artifacts.require("FunctionsAndErrors");

   module.exports = function (deployer) {
     deployer.deploy(FunctionsAndErrors);
   };
   ```

4. Start Truffle Console in Development Mode

   ```bash
   truffle develop
   ```

   In the Truffle console, execute:

   ```bash
   compile
   migrate
   ```

   To remigrate existing contracts, use `migrate --reset` instead of simply `migrate`.

## Functions

### `setName(string _name)`
Sets the name of the user. Requires the name not to be empty.

### `logDistance(uint _distance)`
Logs the distance (in km) traveled by the user. Requires the distance to be greater than 0 and ensures data consistency.

### `logCarbs(uint256 _carbs)`
Logs carbohydrate intake (in grams). Requires carbs to be greater than 0 and ensures data consistency.

### `logSteps(uint256 _steps)`
Logs the number of steps taken. Requires steps to be greater than 0 and ensures data consistency.

### `resetHealthRecord()`
Resets the user’s health records. Reverts if the records are already reset.

### `getHealthRecord()`
Returns the user’s health record, including:
- Name
- Distance
- Carbs
- Steps

## Authors

John Gabriel T. Pagtalunan  
@202120016@fit.edu.ph  
@j.g.pagtalunan14@gmail.com

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
