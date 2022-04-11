pragma solidity ^0.5.2;

/**
 * DAO contract:
 * 1. Collects investors money (ether) & allocate shares
 * 2. Keep track of investor contributions with shares
 * 3. Allow investors to transfer shares
 * 4. allow investment proposals to be created and voted
 * 5. execute successful investment proposals (i.e send money)
 */

contract DAO {
    struct Proposal {
        uint256 id;
        string name;
        uint256 amount;
        address payable recipient;
        uint256 votes;
        uint256 end;
        bool executed;
    }

    mapping(address => bool) public investors;
    mapping(address => uint256) public shares; //no. of shares allocated by each investor
    mapping(uint256 => Proposal) public proposals;
    mapping(address => mapping(uint256 => bool)) public votes;
    uint256 public totalShares;
    uint256 public availableFunds;
    uint256 public contributionEnd; //time when the DAO will stop to accept funds(closed funds)
    uint256 public nextProposalId;
    uint256 public voteTime;
    uint256 public quorum;
    address public admin;

    constructor(
        uint256 contributionTime,
        uint256 _voteTime,
        uint256 _quorum
    ) public {
        require(
            _quorum > 0 && _quorum < 100,
            "quorum must be between 0 and 100"
        );
        contributionEnd = now + contributionTime;
        voteTime = _voteTime;
        quorum = _quorum;
        admin = msg.sender;
    }

    function contribute() external payable {
        require(
            now < contributionEnd,
            "cannot contribute after contributionEnd"
        );
        investors[msg.sender] = true;
        shares[msg.sender] += msg.value;
        totalShares += msg.value;
        availableFunds += msg.value;
    }

    function redeemShare(uint256 amount) external {
        require(shares[msg.sender] >= amount, "not enough shares");
        require(availableFunds >= amount, "not enough availableFunds");
        shares[msg.sender] -= amount;
        availableFunds -= amount;
        msg.sender.transfer(amount);
    }

    function transferShare(uint256 amount, address to) external {
        require(shares[msg.sender] >= amount, "not enough shares");
        shares[msg.sender] -= amount;
        shares[to] += amount;
        investors[to] = true;
    }

    function createProposal(
        string memory name,
        uint256 amount,
        address payable recipient
    ) public onlyInvestors {
        require(availableFunds >= amount, "amount too big");
        proposals[nextProposalId] = Proposal(
            nextProposalId,
            name,
            amount,
            recipient,
            0,
            now + voteTime,
            false
        );
        availableFunds -= amount;
        nextProposalId++;
    }

    function vote(uint256 proposalId) external onlyInvestors {
        Proposal storage proposal = proposals[proposalId];
        require(
            votes[msg.sender][proposalId] == false,
            "investor can only vote once for a proposal"
        );
        require(now < proposal.end, "can only vote until proposal end");
        votes[msg.sender][proposalId] = true;
        proposal.votes += shares[msg.sender];
    }

    function executeProposal(uint256 proposalId) external onlyAdmin {
        Proposal storage proposal = proposals[proposalId];
        require(
            now >= proposal.end,
            "cannot execute a proposal before end date"
        );
        require(
            proposal.executed == false,
            "cannot execute a proposal already executed"
        );
        require(
            (proposal.votes * 100) / totalShares >= quorum,
            "cannot execute proposal with votes # below quorum"
        );
        proposal.executed = true;
        _transferEther(proposal.amount, proposal.recipient);
    }

    function withdrawEther(uint256 amount, address payable to)
        external
        onlyAdmin
    {
        _transferEther(amount, to);
    }

    //For ether returns of proposal investments
    function() external payable {
        availableFunds += msg.value;
    }

    function _transferEther(uint256 amount, address payable to) internal {
        require(amount <= availableFunds, "not enough availableFunds");
        availableFunds -= amount;
        to.transfer(amount);
    }

    modifier onlyInvestors() {
        require(investors[msg.sender] == true, "only investors");
        _;
    }
    modifier onlyAdmin() {
        require(msg.sender == admin, "only admin");
        _;
    }
}
