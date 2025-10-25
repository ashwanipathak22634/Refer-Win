// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ReferralReward {
    address public owner;

    mapping(address => address) public referrerOf;
    mapping(address => uint256) public rewards;

    uint256 public rewardAmount = 0.01 ether;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    function registerReferral(address _referrer) public {
        require(_referrer != msg.sender, "Cannot refer yourself");
        require(referrerOf[msg.sender] == address(0), "Already referred");
        referrerOf[msg.sender] = _referrer;
        rewards[_referrer] += rewardAmount;
    }

    function claimReward() public {
        uint256 amount = rewards[msg.sender];
        require(amount > 0, "No rewards to claim");
        rewards[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    // Owner can fund contract
    receive() external payable {}
}
