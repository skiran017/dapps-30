const Escrow = artifacts.require('Escrow');

module.exports = function (deployer, _network, accounts) {
  // deployer.deploy(
  //   Escrow,
  //   accounts[1], //payer
  //   accounts[2], //payee
  //   1000,
  //   { from: accounts[0] }
  // );
  //for test
  deployer.deploy(Escrow, accounts[1], accounts[2], 1000);
};
