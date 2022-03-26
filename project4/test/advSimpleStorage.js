const AdvSimpleStorage = artifacts.require('AdvSimpleStorage');

contract('AdvSimpleStorage', () => {
  let advSimpleStorage = null;
  before(async () => {
    advSimpleStorage = await AdvSimpleStorage.deployed();
  });
  it('should add an element to ids array', async () => {
    await advSimpleStorage.add(10);
    const result = await advSimpleStorage.ids(0);
    assert(result.toNumber() === 10);
  });

  it('should get an element of the ids array', async () => {
    await advSimpleStorage.add(20);
    const result = await advSimpleStorage.get(1);
    assert(result.toNumber() === 20);
  });

  it('should get ids array', async () => {
    const rawIds = await advSimpleStorage.getAll();
    const ids = rawIds.map((id) => id.toNumber());
    //deepEqual compare the elements within the array
    assert.deepEqual(ids, [10, 20]);
  });

  it('should get length of the ids array', async () => {
    const length = await advSimpleStorage.length();
    assert(length.toNumber() === 2);
  });
});
