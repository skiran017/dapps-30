const DeedMultiPayout = artifacts.require('DeedMultiPayout');

module.exports = function (deployer, _network, accounts) {
  deployer.deploy(DeedMultiPayout, accounts[0], accounts[1], 1, { value: 100 });
  //accounts[0]=lawyer address
  //account[1]= beneficiary address
  //time = 1s
  //value = amount to be sent to beneficiary
};
