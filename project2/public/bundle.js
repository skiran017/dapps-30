// var contractABI = [];
// var contractAddress = '0xfebD1e2CDB3Ce30f02c3dBC26130a3c6631A8839';

// var web3 = new Web3('http://localhost:9545');
// var simpleSmartContract = new web3.eth.Contract(contractABI, contractAddress);

// console.log(simpleSmartContract);

// web3.eth.getAccounts().then(console.log);

var contractABI = [
  {
    constant: true,
    inputs: [],
    name: 'hello',
    outputs: [
      {
        name: '',
        type: 'string',
      },
    ],
    payable: false,
    stateMutability: 'pure',
    type: 'function',
  },
];
var contractAddress = '0xfebD1e2CDB3Ce30f02c3dBC26130a3c6631A8839';

var web3 = new Web3('http://localhost:9545');

var helloWorld = new web3.eth.Contract(contractABI, contractAddress);

document.addEventListener('DOMContentLoaded', () => {
  helloWorld.methods
    .hello()
    .call()
    .then((result) => {
      document.getElementById('hello').innerHTML = result;
    });
});
