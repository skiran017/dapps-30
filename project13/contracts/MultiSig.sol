pragma solidity ^0.5.2;

contract MultiSig {
    address[] public approvers;
    uint256 public quorum;

    struct Transfer {
        uint256 id;
        uint256 amount;
        address payable to;
        uint256 approvals;
        bool sent;
    }

    //made it to public to test it
    mapping(uint256 => Transfer) public transfers;
    uint256 public nextId;
    mapping(address => mapping(uint256 => bool)) public approvals;

    constructor(address[] memory _approvers, uint256 _quorum) public payable {
        approvers = _approvers;
        quorum = _quorum;
    }

    function createTransfer(uint256 amount, address payable to)
        external
        onlyApprover
    {
        transfers[nextId] = Transfer(nextId, amount, to, 0, false);
        nextId++;
    }

    function sendTransfer(uint256 id) external onlyApprover {
        require(transfers[id].sent == false, "transfer has already been sent");
        if (approvals[msg.sender][id] == false) {
            approvals[msg.sender][id] = true;
            transfers[id].approvals++;
        }
        if (transfers[id].approvals >= quorum) {
            transfers[id].sent = true;
            address payable to = transfers[id].to;
            uint256 amount = transfers[id].amount;
            to.transfer(amount);
            return;
        }
    }

    modifier onlyApprover() {
        bool allowed = false;
        for (uint256 i = 0; i < approvers.length; i++) {
            if (approvers[i] == msg.sender) {
                allowed = true;
            }
        }
        require(allowed == true, "only approver allowed");
        _;
    }
}
