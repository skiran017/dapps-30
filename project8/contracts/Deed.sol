pragma solidity ^0.5.0;

contract Deed {
    address public lawyer;
    address payable public beneficiary;
    uint256 public earliest; //unique timestamp || date

    constructor(
        address _lawyer,
        address payable _beneficiary,
        uint256 fromNow
    ) public payable {
        lawyer = _lawyer;
        beneficiary = _beneficiary;
        earliest = now + fromNow;
    }

    function withdraw() public {
        require(msg.sender == lawyer, "lawyer only");
        require(now >= earliest, "too early");
        beneficiary.transfer(address(this).balance); //send eveything to beneficiary
    }
}
