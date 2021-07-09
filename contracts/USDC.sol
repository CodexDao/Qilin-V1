// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.7.6;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract USDC is Ownable, ERC20("USDC", "USDC") {
    using SafeMath for uint256;
    mapping(address => bool) private minters;

    constructor() {
        _setupDecimals(6);
    }

    function mint(address to_, uint256 value_) external onlyOwner {
        _mint(to_, value_);
    }

    function selfMint(uint256 value_) external {
        require(!minters[msg.sender], "you have minted already");
        require(value_ <= 20000000000000000000000, "self mint must less than 20000U");
        _mint(msg.sender, value_);
        minters[msg.sender] = true;
    }

    function burn(address from_, uint256 value_) external onlyOwner {
        require(balanceOf(from_) >= value_, "USDC is not enough");
        _burn(from_, value_);
    }

    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
}
