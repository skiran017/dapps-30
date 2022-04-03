pragma solidity ^0.5.0;

contract SplitPayment {
    address public owner;

    constructor(address _owner) public {
        owner = _owner;
    }

    function send(address payable[] memory to, uint256[] memory amount)
        public
        payable
        onlyOwner
    {
        require(
            to.length == amount.length,
            "to and amount arrays must have same length"
        );
        for (uint256 i = 0; i < to.length; i++) {
            to[i].transfer(amount[i]);
        }
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can send transactions");
        _;
    }
}
