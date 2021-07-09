// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.7.6;

interface ISidePool {
    function deposit(address user, uint256 amount) external;
    function claim(address user, uint256 amount) external;
}
