require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: "./.env" });

module.exports = {
  solidity: "0.8.17",
  settings: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  },
  networks: {
    baobab: {
      url:'https://api.baobab.klaytn.net:8651',
      gasPrice: 250000000000,
      accounts: [process.env.NEXT_PRIVATEKEY], 
    }
  }
};
