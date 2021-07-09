// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.7.6;

import "@chainlink/contracts/src/v0.5/interfaces/AggregatorV2V3Interface.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract TestAggregator is Ownable, AggregatorV2V3Interface {
    uint8 _decimals;
    int256 _answer;
    uint256 _timestamp;
    uint256 _round;

    function setDecimals(uint8 dec) external onlyOwner {
        _decimals = dec;
    }

    function setState(
        int256 answer,
        uint256 timestamp,
        uint256 round
    ) external onlyOwner {
        _answer = answer;
        if (timestamp != 0) {
            _timestamp = timestamp;
        } else {
            _timestamp = block.timestamp;
        }

        if (round != 0) {
            _round = round;
        } else {
            _round = _round + 1;
        }
    }

    function decimals() external view override returns (uint8) {
        return _decimals;
    }

    function latestAnswer() external view override returns (int256) {
        return _answer;
    }

    function latestTimestamp() external view override returns (uint256) {
        return _timestamp;
    }

    function latestRound() external view override returns (uint256) {
        return _round;
    }

    function getAnswer(uint256 roundId)
        external
        pure
        override
        returns (int256)
    {
        require(false, "this api getAnswer not available in current");
        // empty
        return 0;
    }

    function getTimestamp(uint256 roundId)
        external
        pure
        override
        returns (uint256)
    {
        require(false, "this api getTimestamp not available in current");
        // empty
        return 0;
    }

    function description() external pure override returns (string memory) {
        return "just for test";
    }

    function version() external pure override returns (uint256) {
        return 1;
    }

    // getRoundData and latestRoundData should both raise "No data present"
    // if they do not have data to report, instead of returning unset values
    // which could be misinterpreted as actual reported values.
    function getRoundData(uint80 _roundId)
        external
        pure
        override
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        )
    {
        require(false, "this api getRoundData not available in current");
        // empty
        return (0, 0, 0, 0, 0);
    }

    function latestRoundData()
        external
        pure
        override
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        )
    {
        require(false, "this api latestRoundData not available in current");
        // empty
        return (0, 0, 0, 0, 0);
    }
}
