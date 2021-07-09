// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.7.6;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract ControlerRole is Ownable, AccessControl {
    bytes32 public constant CONTROLER_ROLE = keccak256("CONTROLER_ROLE");

    modifier onlyControler() {
        require(isControler(_msgSender()), "ControlerRole: caller does not have the Controler role");
        _;
    }

    function isControler(address account) public view returns (bool) {
        return hasRole(CONTROLER_ROLE, account) || (owner() == account);
    }

    function addControler(address account) public onlyOwner {
        _setupRole(CONTROLER_ROLE, account);
    }

    function renounceSigner() public {
        renounceRole(CONTROLER_ROLE, _msgSender());
    }

    function removeControler(address account) public onlyOwner {
        revokeRole(CONTROLER_ROLE, account);
    }
}
