// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ReferralReward {
    address public owner;

    mapping(address => address) public referrerOf;
    mapping(address => uint256) public rewards;

    uint256 public rewardAmount = 0.01 ether;

    event ReferralRegistered(address indexed referrer, address indexed referee, uint256 reward);
    event RewardClaimed(address indexed user, uint256 amount);
    event RewardAmountUpdated(uint256 oldAmount, uint256 newAmount);
    event FundsWithdrawn(address indexed owner, uint256 amount);
    event ContractFunded(address indexed sender, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    // Register a new referral
    function registerReferral(address _referrer) public {
        require(_referrer != msg.sender, "Cannot refer yourself");
        require(referrerOf[msg.sender] == address(0), "Already referred");
        require(_referrer != address(0), "Invalid referrer");

        referrerOf[msg.sender] = _referrer;
        rewards[_referrer] += rewardAmount;

        emit ReferralRegistered(_referrer, msg.sender, rewardAmount);
    }

    // Claim accumulated rewards
    function claimReward() public {
        uint256 amount = rewards[msg.sender];
        require(amount > 0, "No rewards to claim");
        require(address(this).balance >= amount, "Insufficient contract balance");

        rewards[msg.sender] = 0;
        payable(msg.sender).transfer(amount);

        emit RewardClaimed(msg.sender, amount);
    }

    // Update reward amount (owner only)
    function updateRewardAmount(uint256 _newAmount) public onlyOwner {
        uint256 oldAmount = rewardAmount;
        rewardAmount = _newAmount;
        emit RewardAmountUpdated(oldAmount, _newAmount);
    }

    // Owner withdraws contract funds
    function withdrawFunds(uint256 _amount) public onlyOwner {
        require(address(this).balance >= _amount, "Insufficient balance");
        payable(owner).transfer(_amount);
        emit FundsWithdrawn(owner, _amount);
    }

    // Deposit ETH into contract
    receive() external payable {
        emit ContractFunded(msg.sender, msg.value);
    }
}
