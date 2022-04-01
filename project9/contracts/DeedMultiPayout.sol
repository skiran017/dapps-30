pragma solidity ^0.5.0;

contract DeedMultiPayout {
    address public lawyer;
    address payable public beneficiary;
    uint256 public earliest; //unique timestamp || date
    uint256 public amount; //in WEI

    //helps to save gas by storing variable in code rather than in storage of blockchain; this cannot be modified later
    uint256 public constant PAYOUTS = 10;
    uint256 public constant INTERVAL = 10; //time between each payout in seconds (unit by default)
    uint256 public paidPayouts;

    constructor(
        address _lawyer,
        address payable _beneficiary,
        uint256 fromNow
    ) public payable {
        lawyer = _lawyer;
        beneficiary = _beneficiary;
        earliest = now + fromNow;
        amount = msg.value / PAYOUTS;
    }

    function withdraw() public {
        require(msg.sender == beneficiary, "beneficiary only");
        require(now >= earliest, "too early");
        require(paidPayouts < PAYOUTS, "no payouts left");

        uint256 eligiblePayouts = (now - earliest) / INTERVAL;
        uint256 duePayouts = eligiblePayouts - paidPayouts;
        duePayouts = duePayouts + paidPayouts > PAYOUTS
            ? PAYOUTS - paidPayouts
            : duePayouts;
        paidPayouts += duePayouts;
        beneficiary.transfer(duePayouts * amount);
    }
}
