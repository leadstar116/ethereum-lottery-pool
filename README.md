# Ethereum Lottery Pool

A simple lottery pool on Ethereum network.

## Used Stacks

- Solidity
- Mocha
- Ganache (Local contract deploy & test)
- solc (for compiling the contract)
- Infura (for deployment)

## Main Functionalities of App

1. Player can enter lottery with more than 0.1 ether

2. Only manager (who created the pool) can run `pickWinner` function.

3. `pickWinner` will pick random player as a winner and send all balance of the pool to the winner.

# Project Run

Using node version 14 and run `npm install` for installing the dependencies.

## Available Scripts

In the project directory, you can run:

### `npm run compile`

This will compile the contract and get `abi` and `bytecode` for contract deployment.

### `npm run deploy`

This will deploy the contract to Rinkeby network.
I am using `Infura` and `@truffle/hdwallet-provider` for quick deployment.
You will have to setup your own Infura account, create a new project and update the infura url.

### `npm run test`

Automated test for contract. Using Mocha library, testing several functions and logics for contract.
