# FunctionsAndErrors - A Metacrafters Project for ETH + AVAX Proof

This Solidity project demonstrates the use of `require()`, `assert()`, and `revert()` statements through a personal health monitoring system deployed on the Ethereum blockchain.

---

## Description

The **FunctionsAndErrors** contract allows users to log and manage their health data securely. Key features include:

- Setting user profiles with name, age, and sex.
- Tracking distance traveled (in kilometers), carbohydrate intake (in grams), and steps taken.
- Retrieving and resetting health records.
- Estimating calories burned and weight lost based on walking duration and body weight.

Error-handling mechanisms ensure data integrity and proper input validation.

---

## Features and Functions

### User Profile
- **`setUser(string _name, uint _sex, uint _age)`**  
  Sets the user's name, sex (`1` for male, `2` for female), and age.  
  - Requires: 
    - Non-empty name.  
    - Valid sex (`1` or `2`).  
    - Age must be 18 or older.  

### Health Tracking
- **`logDistance(uint _distance)`**  
  Logs the distance traveled. Ensures the distance is greater than 0 km.

- **`logCarbs(uint _carbs)`**  
  Records carbohydrate intake. Ensures carbs are greater than 0 grams.

- **`logSteps(uint _steps)`**  
  Tracks steps taken. Ensures steps are greater than 0.

### Reset and Retrieval
- **`resetHealthRecord()`**  
  Resets health records to zero. Reverts if all values are already zero.

- **`getHealthRecord()`**  
  Retrieves the user's health record, returning the name, distance, carbs, and steps.

### Weight Loss Estimation
- **`calcWeightLost(uint _walkTime, uint _weight)`**  
  Calculates calories burned and weight lost based on:
  - Walk duration (minutes).
  - Body weight (kg).
  - MET values based on sex (`4` for males, `3` for females).  

---

## Getting Started

### Installation

1. **Install Node.js**  
   [Download Node.js](https://nodejs.org) from the official site and follow the installation instructions.

2. **Install Truffle**  
   Install Truffle globally:  
   ```bash
   npm install -g truffle
   ```

---

### Running the Contract

1. **Initialize Truffle**  
   ```bash
   truffle init
   ```

2. **Add Contract**  
   Save the `FunctionsAndErrors.sol` contract in the `contracts` directory.

3. **Create Migration File**  
   Add `2_deploy_functions_and_errors.js` in the `migrations` folder:  
   ```javascript
   const FunctionsAndErrors = artifacts.require("FunctionsAndErrors");

   module.exports = function (deployer) {
       deployer.deploy(FunctionsAndErrors);
   };
   ```

4. **Compile and Deploy**  
   Use Truffle's development environment to compile and deploy the contract:  
   ```bash
   truffle develop
   compile
   migrate --reset
   ```

---

## Usage

Deploy and interact with the contract using a blockchain development environment such as [Remix](https://remix.ethereum.org) or Truffle.  

Example commands in Truffle console:
```javascript
// Set user profile
await contractInstance.setUser("John Doe", 1, 25);

// Log activities
await contractInstance.logDistance(5); // Add 5 km
await contractInstance.logCarbs(100); // Add 100 grams of carbs
await contractInstance.logSteps(2000); // Add 2000 steps

// Retrieve health record
let record = await contractInstance.getHealthRecord();
console.log(record);
```

---

## Authors

**John Gabriel T. Pagtalunan**  
- **Email:** 202120016@fit.edu.ph  
- **GitHub:** [John Pagtalunan](https://github.com/j.g.pagtalunan14)  

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.  
