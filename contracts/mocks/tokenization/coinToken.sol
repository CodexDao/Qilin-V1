// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.7.6;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

import "../../utils/ControlerRole.sol";

contract coinToken is ERC20("COIN", "COIN"), ControlerRole {
    using SafeMath for uint256;

    constructor() public {
        _mint(msg.sender, 100000000000000000000000000);
    }

    function mint(uint256 amount) public onlyControler {
        _mint(msg.sender, amount);
    }
}
