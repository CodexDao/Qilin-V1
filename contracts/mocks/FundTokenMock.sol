// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.7.6;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "../FundToken.sol";

contract FundTokenMock is Ownable, FundToken {
    constructor(address exchanger_) FundToken(exchanger_) { }

    function mint_(address to_, uint256 value_) external {
        _mint(to_, value_);
    }

    function burn_(address from_, uint256 value_) external {
        _burn(from_, value_);
    }
}