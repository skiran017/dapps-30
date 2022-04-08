pragma solidity ^0.5.2;
pragma experimental ABIEncoderV2;

contract Voting {
    mapping(address => bool) public voters;
    struct Choice {
        uint256 id;
        string name;
        uint256 votes;
    }
    struct Ballot {
        uint256 id;
        string name;
        Choice[] choices;
        uint256 end; //time stamp in seconds
    }

    mapping(uint256 => Ballot) ballots;
    uint256 nextBallotId;
    address public admin;
    mapping(address => mapping(uint256 => bool)) votes;

    constructor() public {
        admin = msg.sender;
    }

    function addVoters(address[] calldata _voters) external onlyAdmin {
        for (uint256 i = 0; i < _voters.length; i++) {
            voters[_voters[i]] = true;
        }
    }

    function createBallot(
        string memory name,
        string[] memory _choices,
        uint256 offset
    ) public onlyAdmin {
        ballots[nextBallotId].id = nextBallotId;
        ballots[nextBallotId].name = name;
        ballots[nextBallotId].end = now + offset;
        for (uint256 i = 0; i < _choices.length; i++) {
            ballots[nextBallotId].choices.push(Choice(i, _choices[i], 0));
        }
        nextBallotId++;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "only admin");
        _;
    }
}
