// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Lottery
 * @dev Implements simple lottery pool and pick winner
 */
contract Lottery {
    address[] public players;
    address public manager;

    /**
     * @dev Save contract creator as a manager. Only manager would be able to run pickWinner function.
     */
    constructor() {
        manager = msg.sender;
    }

    /**
     * @dev Throws if called by any account other than the manager.
     */
    modifier onlyManager() {
        require(msg.sender == manager, "Only manager can perform this action!");
        _;
    }

    /**
     * @dev Enter lottery. Throws if called by less than 0.1 ETH.
     */
    function enter() public payable {
        require(msg.value >= .01 ether, "Value should be greater than 0.1ETH!");
        players.push(msg.sender);
    }

    /**
     * @dev Private random number generator function based on block difficulty and timestamp.
     */
    function random() private view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(block.difficulty, block.timestamp, players)
                )
            );
    }

    /**
     * @dev Withdraw money to the receiver.
     */
    function withdraw(address payable receiver, uint256 amount)
        private
        onlyManager
    {
        (bool success, ) = receiver.call{value: amount}("");

        require(success, "Failed to withdraw balance to the winner!");
    }

    /**
     * @dev Pick winner. Only able to be called by manager and winner would take all balance of lottery.
     */
    function pickWinner() public onlyManager {
        uint256 index = random() % players.length;
        withdraw(payable(players[index]), address(this).balance);
        players = new address[](0);
    }

    /**
     * @dev Return balance of lottery.
     */
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    /**
     * @dev Return array of players.
     */
    function getPlayers() public view returns (address[] memory) {
        return players;
    }
}
