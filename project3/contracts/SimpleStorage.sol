// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

// contract SimpleStorage {
//     string public data;

//     function set(string memory _data) public {
//         data = _data;
//     }

//     //view keyword is to read storage data of the smart contract and pure keyword is to read static data
//     function get() public view returns (string memory) {
//         return data;
//     }
// }

contract SimpleStorage {
    uint256 storedData;

    function set(uint256 x) public {
        storedData = x;
    }

    //view keyword is to read storage data of the smart contract and pure keyword is to read static data
    function get() public view returns (uint256) {
        return storedData;
    }
}
