const Deed = artifacts.require('Deed');

module.exports = function (deployer, _network, accounts) {
  deployer.deploy(Deed, accounts[0], accounts[1], 5, { value: 100 });
  //accounts[0]=lawyer address
  //account[1]= beneficiary address
  //time = 5s
  //value = amount to be sent to beneficiary
};
