// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.7.6;
pragma abicoder v2;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "../interfaces/IDepot.sol";
import "../utils/BasicMaths.sol";

import "../Depot.sol";

contract IntTest is Depot {
    using SafeMath for uint;
    using BasicMaths for uint;

    constructor(address[] memory powers) Depot(powers){
    }

    function testParams() external pure returns (uint) {
        // In `newPosition`, the params is:
        // - openPositionPrice from other contracts a uint
        // - margin --> position : user def
        // - level : user def, a uint16 0 -- 65535

        uint margin = uint(2 ** 172);
        uint16 level = 100;

        // from newPosition
        uint leveragedPosition = margin.mul(level);
        uint share = leveragedPosition.mul(1e18) / 1e18;

        return share;
    }

    function overflow() pure public returns (uint256, uint136, uint168, uint128) {
        uint256 max1 = 2 ** 256 - 1;
        uint128 max2 = 2 ** 128 - 1;
        uint136 max3 = 2 ** 136 - 1;
        uint168 max4 = 2 ** 168 - 1;
        return (max1, max3, max4, max2);
    }

}