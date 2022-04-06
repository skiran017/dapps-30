const MultiSig = artifacts.require('MultiSig');

module.exports = function (deployer, _network, accounts) {
  deployer.deploy(MultiSig, [accounts[0], accounts[1], accounts[2]], 2, {
    value: 1000,
  });
};
