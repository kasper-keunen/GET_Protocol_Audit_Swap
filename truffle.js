var HDWalletProvider = require("@truffle/hdwallet-provider");

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // for more about customizing your Truffle configuration!
  networks: { },
  compilers: { 
    solc: {
      version: "0.5.0",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      },
     }
   }
 }
};
