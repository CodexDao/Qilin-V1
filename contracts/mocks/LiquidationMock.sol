// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.7.6;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "../utils/AddressResolver.sol";
import "../utils/BasicMaths.sol";

import "../Liquidation.sol";

contract LiquidationMock is Liquidation {
    using SafeMath for uint;
    using BasicMaths for uint;
    using BasicMaths for bool;

    function getLiquidationStat(uint32 positionId) external view returns( uint, uint, uint, uint, uint, uint, uint ) {
        IDepot depot = getDepot();
        ISystemSetting setting = systemSetting();

        Position memory position;
        (
            position.account,
            position.share,
            position.leveragedPosition,
            position.openPositionPrice,
            position.currencyKeyIdx,
            position.direction,
            position.margin,
            position.openRebaseLeft
        ) = depot.position(positionId);

        uint serviceFee = position.leveragedPosition.mul(setting.positionClosingFee()) / 1e18;
        uint marginLoss = depot.calMarginLoss(position.leveragedPosition, position.share, position.direction);

        uint rateForCurrency = exchangeRates().rateForCurrencyByIdx(position.currencyKeyIdx);
        uint value = position.leveragedPosition.mul(rateForCurrency.diff(position.openPositionPrice)) / position.openPositionPrice;

        return (
            position.margin,
            serviceFee,
            marginLoss,
            rateForCurrency,
            value,
            position.margin.sub(value).sub(serviceFee).sub(marginLoss),
            position.margin.mul(setting.marginRatio()) / 1e18
        );
    }
}