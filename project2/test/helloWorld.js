const HelloWorld = artifacts.require('HelloWorld'); // contract artifact(name of the smart contract)

contract('HelloWorld', () => {
  it('Should return hello world', async () => {
    const helloWorld = await HelloWorld.deployed(); //contract instance
    const result = await helloWorld.hello();
    assert(result === 'Hello World');
  });
});
