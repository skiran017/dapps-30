const SimpleSmartContract = artifacts.require('SimpleSmartContract');

contract('SimpleSmartContract', () => {
  it('should deploy smart contarct properly', async () => {
    const simpleSmartContract = await SimpleSmartContract.deployed();
    // console.log(simpleSmartContract.address);
    assert(simpleSmartContract.address != '');
  });
});
