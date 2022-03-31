const EtherWallet = artifacts.require('EtherWallet');

contract('EtherWallet', (accounts) => {
  let etherWallet = null;
  before(async () => {
    etherWallet = await EtherWallet.deployed();
  });

  it('Should set accounts[0] as owner', async () => {
    const owner = await etherWallet.owner();
    assert(owner === accounts[0]);
  });

  it('Should deposit ether to etherWallet', async () => {
    await etherWallet.deposit({
      from: accounts[0], //if not specified, by default it will be accounts[0], just to be sure we specify
      value: 100, //100 WEI
    });
    const balance = await web3.eth.getBalance(etherWallet.address); //return a string
    assert(parseInt(balance) === 100);
  });

  it('Should return the balance of the contract', async () => {
    const balance = await etherWallet.balanceOf();
    assert(parseInt(balance) === 100);
  });

  it('Should transfer ether to another address', async () => {
    const balanceRecipientBefore = await web3.eth.getBalance(accounts[1]);

    await etherWallet.send(accounts[1], 50, {
      from: accountts[0],
    });
    const balanceWallet = await web3.eth.getBalance(etherWallet.address);
    assert(parseInt(balanceWallet) === 50);
    // as result is very large we use .toBN()
    const balanceRecipientAfter = await web3.eth.getBalance(accounts[1]);
    const finalBalance = web3.utils.toBN(balanceRecipientAfter);
    const initialBalance = web3.utils.toBN(balanceRecipientBefore);

    assert(finalBalance.sub(initialBalance).toNumber() === 50);
  });

  it('Should NOT transfer ether if tx not sent from owner', async () => {
    try {
      await etherWallet.send(accounts[1], 50, {
        from: accounts[2],
      });
    } catch (error) {
      assert(error.message.includes('sender is not allowed'));
      return;
    }
    assert(false);
  });
});
