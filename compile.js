const path = require("path");
const fs = require("fs");
const solc = require("solc");

const inboxPath = path.resolve(__dirname, "contracts", "Lottery.sol");
const source = fs.readFileSync(inboxPath, "utf-8").toString();

const input = {
  language: "Solidity",
  sources: {
    "Lottery.sol": {
      content: source,
    },
  },
  settings: {
    outputSelection: {
      "*": {
        "*": ["*"],
      },
    },
  },
};

const result = JSON.parse(solc.compile(JSON.stringify(input)));

module.exports = {
  abi: result.contracts["Lottery.sol"].Lottery.abi,
  bytecode: result.contracts["Lottery.sol"].Lottery.evm.bytecode.object,
};
