import Web3 from 'web3';
import AdvancedStorage from '../build/contracts/AdvancedStorage.json';

let web3;
let advancedStorage;

const initWeb3 = () => {
  return new Promise((resolve, reject) => {
    //Case 1: old metamask is present
    if (typeof window.web3 !== 'undefined') {
      return resolve(new Web3(window.web3.currentProvider));
    }
    //Case 2: new metamask is present
    if (typeof window.ethereum !== 'undefined') {
      window.ethereum
        .enable()
        .then(() => {
          resolve(new Web3(window.ethereum));
        })
        .catch((e) => reject(e));
      return;
    }

    //Case 3: no metamask present, just connect to Gnache
    resolve(new Web3('http://localhost:9545'));
  });
};

const initContract = () => {
  AdvancedStorage;
  return new web3.eth.Contract();
};

const initApp = () => {};

document.addEventListener('DOMContentLoaded', () => {
  initWeb3()
    .then((_web3) => {
      web3 = _web3;
      advancedStorage = initContract();
      initApp();
    })
    .catch((e) => console.log(e.message));
});
