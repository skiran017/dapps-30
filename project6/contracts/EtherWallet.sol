// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

contract EtherWallet {
    address public owner;

    constructor(address _owner) public {
        owner = _owner;
    }

    //to receive ether to this function it must be PAYABLE
    function deposit() public payable {}

    //payable address to access transfer function
    function send(address payable to, uint256 amount) public {
        if (msg.sender == owner) {
            to.transfer(amount);
            return;
        }
        revert("sender is not allowed");
    }

    function balanceOf() public view returns (uint256) {
        return address(this).balance;
    }
}
