// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.7.6;
pragma abicoder v2;

import "@openzeppelin/contracts/math/SafeMath.sol";

import "../Depot.sol";

contract DepotMock is Depot {
    constructor(address[] memory powers) Depot(powers) {}

    function getPower_(address add) public view returns (uint8) {
        return _powers[add];
    }

    function positionsByAccount(address account) external view returns (uint32[] memory) {
        uint length = 0;
        uint index = 0;

        for (uint32 i = 1; i <= _positionIndex; i++) {
            if (_positions[i].account == account) {
                length++;
            }
        }

        uint32[] memory res = new uint32[](length);
        for (uint32 i = 1; i <= _positionIndex; i++){
            if (_positions[i].account == account) {
                res[index++] = i;
            }
        }

        return res;
    }

    function allPositions() external view returns (uint32[] memory) {
        uint length = 0;
        uint index = 0;

        for (uint32 i = 1; i <= _positionIndex; i++) {
            if (_positions[i].account != address(0)) {
                length++;
            }
        }

        uint32[] memory res = new uint32[](length);
        for (uint32 i = 1; i <= _positionIndex; i++) {
            if (_positions[i].account != address(0)) {
                res[index++] = i;
            }
        }

        return res;
    }

    function getCurrPosIdx() external view returns (uint32){
        return _positionIndex;
    }
}