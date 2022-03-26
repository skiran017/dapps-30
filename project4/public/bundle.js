const simpleStorageABI = [
  {
    constant: false,
    inputs: [
      {
        name: 'x',
        type: 'uint256',
      },
    ],
    name: 'set',
    outputs: [],
    payable: false,
    stateMutability: 'nonpayable',
    type: 'function',
  },
  {
    constant: true,
    inputs: [],
    name: 'get',
    outputs: [
      {
        name: '',
        type: 'uint256',
      },
    ],
    payable: false,
    stateMutability: 'view',
    type: 'function',
  },
];
const simpleStorageAddress = '0xea94602b88c8c065e5228AC75b27666BAEC35F0c';
const web3 = new Web3('http://localhost:9545');
const simpleStorage = new web3.eth.Contract(
  simpleStorageABI,
  simpleStorageAddress
);

document.addEventListener('DOMContentLoaded', () => {
  const $setData = document.getElementById('setData');
  const $data = document.getElementById('data');
  let accounts = [];

  web3.eth.getAccounts().then((_accounts) => {
    accounts = _accounts;
  });

  const getData = () => {
    simpleStorage.methods
      .get()
      .call()
      .then((result) => {
        $data.innerHTML = result;
      });
  };
  getData();

  $setData.addEventListener('submit', (e) => {
    e.preventDefault();
    const data = e.target.elements[0].value;
    simpleStorage.methods
      .set(data)
      .send({
        from: accounts[0],
      })
      .then(getData);
  });
});
