const fs = require('fs');
const HDWalletProvider = require('@truffle/hdwallet-provider');

const secrets = JSON.parse(fs.readFileSync('.secrets.json').toString().trim());

module.exports = {
  networks: {
    ropsten: {
      provider: () =>
        new HDWalletProvider(
          secrets.seed,
          `https://eth-ropsten.alchemyapi.io/v2/${secrets.projectId}`
        ),
      network_id: 3, // Ropsten's id
      // gas: 5500000, // Ropsten has a lower block limit than mainnet
      // confirmations: 2, // # of confs to wait between deployments. (default: 0)
      // timeoutBlocks: 200, // # of blocks before a deployment times out  (minimum/default: 50)
      // skipDryRun: true, // Skip dry run before migrations? (default: false for public nets )
    },
  },
};
