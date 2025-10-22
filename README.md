🎁 Referral Reward Smart Contract
📌 Overview

The Referral Reward Smart Contract is a simple on-chain incentive mechanism that allows users to refer others and earn rewards. It ensures transparency in referral tracking and automated reward distribution without any centralized intermediary.

⚙️ Features

User Registration: Users can register themselves and optionally provide a referrer.

Automatic Rewarding: Referrers receive a predefined token or ETH reward for every valid referral.

Unique Referral Tracking: Prevents duplicate or circular referrals.

Transparency: All referral data and rewards are stored immutably on the blockchain.

Configurable Reward Amount: Contract owner can set or update the reward per referral.

🧩 Smart Contract Structure
Component	Description
mapping(address => address)	Tracks each user’s referrer.
mapping(address => uint)	Stores total rewards earned by each referrer.
registerReferral(address referrer)	Registers a new user and assigns a referrer.
claimReward()	Allows referrers to withdraw accumulated rewards.
setRewardAmount(uint _amount)	(Owner-only) Updates the reward value.
🧠 Tech Stack

Language: Solidity

Tools: Hardhat / Remix / Foundry

Blockchain: Ethereum / Core / Polygon (testnet recommended)

License: MIT

🚀 Getting Started
1. Clone the Repository
git clone https://github.com/ashwanipathak22634/Refer-Win.git
cd referral-reward-contract

2. Compile the Contract
npx hardhat compile

3. Deploy the Contract
npx hardhat run scripts/deploy.js --network <network-name>

4. Interact

You can interact with the deployed contract via:

Remix IDE

Hardhat console

Ethers.js / Web3.js scripts

🧪 Example Usage
// User registers with a referrer
registerReferral(0x123...abc);  

// Referrer checks total rewards
getRewardBalance(0x123...abc);  

// Referrer claims rewards
claimReward();

🔒 Security Notes

Ensure that only the contract owner can modify reward amounts.

Prevent self-referrals and multiple registrations per address.

Consider using SafeMath or Solidity ^0.8.x for overflow safety.

📄 License

This project is licensed under the MIT License — you may freely use and adapt it for learning or production purposes.