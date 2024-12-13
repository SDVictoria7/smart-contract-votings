// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract Voting {
    struct Voter {
        bool isRegistered;
        bool hasVoted;
        uint8 vote;
    }

    mapping(address => Voter) public voters;
    uint8 public optionCount;
    uint8[] public votes;
    bool public votingEnded;

    modifier onlyRegisteredVoters() {
        require(voters[msg.sender].isRegistered, "Not registered to vote.");
        _;
    }

    modifier votingNotEnded() {
        require(!votingEnded, "Voting has ended.");
        _;
    }

    function registerVoter(address _voter) external {
        require(!voters[_voter].isRegistered, "Voter already registered.");
        voters[_voter].isRegistered = true;
    }

    function vote(uint8 _vote) external onlyRegisteredVoters votingNotEnded {
        require(!voters[msg.sender].hasVoted, "You have already voted.");
        voters[msg.sender].vote = _vote;
        voters[msg.sender].hasVoted = true;
        votes[_vote]++;
    }

    function endVoting() external {
        votingEnded = true;
    }
}
