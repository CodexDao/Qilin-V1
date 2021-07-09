// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.7.6;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "../interfaces/IFluidity.sol";
import "../interfaces/ILiquidation.sol";
import "../interfaces/IExchange.sol";
import "../interfaces/IExchangeRates.sol";
import "../interfaces/IFundToken.sol";
import "../interfaces/ISystemSetting.sol";
import "../interfaces/IDepot.sol";

import "../Exchange.sol";

contract ExchangeMock is Exchange {
    function fundToken_() public view returns (address) {
        return fundToken();
    }

    function exchangeRates_() public view returns (IExchangeRates) {
        return exchangeRates();
    }

    function systemSetting_() public view returns (ISystemSetting) {
        return systemSetting();
    }

    function depotAddress_() public view returns (address) {
        return depotAddress();
    }

    function depot_() public view returns (IDepot) {
        return getDepot();
    }

    function baseCurrency_() public view returns (IERC20) {
        return baseCurrency();
    }
}