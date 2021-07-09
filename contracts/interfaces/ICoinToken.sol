// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.7.6;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface ICoinToken is IERC20 {
    function mint(uint256 amount) external;
}
