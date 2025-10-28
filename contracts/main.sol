// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Refer-Win: Referral Reward Smart Contract
/// @notice Allows users to refer others and earn on-chain rewards in ETH.

contract ReferralReward {
    address public owner;
    uint256 public rewardAmount = 0.01 ether;

    mapping(address => address) public referrerOf;
    mapping(address => uint256) public rewards;

    event ReferralRegistered(address indexed referrer, address indexed referee, uint256 reward);
    event RewardClaimed(address indexed user, uint256 amount);
    event RewardAmountUpdated(uint256 newAmount);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        owner = msg.sender;
    }

    // -----------------------------
    // 🔒 Modifiers
    // -----------------------------
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    // -----------------------------
    // 🧩 Core Functions
    // -----------------------------

    /// @notice Register a referral between referrer and referee.
    /// @param _referrer The address of the referring user.
    function registerReferral(address _referrer) external {
        require(_referrer != msg.sender, "Cannot refer yourself");
        require(referrerOf[msg.sender] == address(0), "Already referred");
        require(_referrer != address(0), "Invalid referrer address");
        require(address(this).balance >= rewardAmount, "Insufficient contract balance");

        referrerOf[msg.sender] = _referrer;
        rewards[_referrer] += rewardAmount;

        emit ReferralRegistered(_referrer, msg.sender, rewardAmount);
    }

    /// @notice Allows referrers to claim their accumulated rewards.
    function claimReward() external {
        uint256 amount = rewards[msg.sender];
        require(amount > 0, "No rewards to claim");

        rewards[msg.sender] = 0;
        payable(msg.sender).transfer(amount);

        emit RewardClaimed(msg.sender, amount);
    }

    // -----------------------------
    // ⚙️  Admin Controls
    // -----------------------------

    /// @notice Update the default reward amount (only owner).
    /// @param _newAmount The new reward amount (in wei).
    function updateRewardAmount(uint256 _newAmount) external onlyOwner {
        require(_newAmount > 0, "Invalid reward amount");
        rewardAmount = _newAmount;

        emit RewardAmountUpdated(_newAmount);
    }

    /// @notice Transfer ownership of the contract to another address.
    function transferOwnership(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "Invalid new owner");
        emit OwnershipTransferred(owner, _newOwner);
        owner = _newOwner;
    }

    // -----------------------------
    // 💰 Funding & Utility
    // -----------------------------

    /// @notice Fund the contract (allows it to pay rewards).
    receive() external payable {}

    /// @notice View current balance of the contract.
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
