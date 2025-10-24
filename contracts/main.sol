// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ReferralReward {
    address public owner;

    mapping(address => address) public referrerOf; // who referred whom
    mapping(address => uint256) public rewards;    // user rewards

    uint256 public rewardAmount = 0.01 ether;      // default reward

    constructor() {
        owner = msg.sender;
    }
}