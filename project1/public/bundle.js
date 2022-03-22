var contractABI = [];
var contractAddress = '0xfebD1e2CDB3Ce30f02c3dBC26130a3c6631A8839';

var web3 = new Web3('http://localhost:9545');
var simpleSmartContract = new web3.eth.Contract(contractABI, contractAddress);

console.log(simpleSmartContract);

web3.eth.getAccounts().then(console.log);
