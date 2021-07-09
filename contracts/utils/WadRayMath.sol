// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.7.6;

import "@openzeppelin/contracts/math/SafeMath.sol";

library WadRayMath {
    using SafeMath for uint256;

    uint256 internal constant WAD = 1e18;
    uint256 internal constant halfWAD = WAD / 2;

    uint256 internal constant RAY = 1e27;
    uint256 internal constant halfRAY = RAY / 2;

    uint256 constant WAD_RAY_RATIO = 1e9;

    function ray() internal pure returns (uint256) {
        return RAY;
    }

    function wad() internal pure returns (uint256) {
        return WAD;
    }

    function halfRay() internal pure returns (uint256) {
        return halfRAY;
    }

    function halfWad() internal pure returns (uint256) {
        return halfWAD;
    }

    function wadMul(uint256 a, uint256 b) internal pure returns (uint256) {
        return halfWAD.add(a.mul(b)).div(WAD);
    }

    function wadDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 halfB = b / 2;

        return halfB.add(a.mul(WAD)).div(b);
    }

    function rayMul(uint256 a, uint256 b) internal pure returns (uint256) {
        return halfRAY.add(a.mul(b)).div(RAY);
    }

    function rayDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 halfB = b / 2;

        return halfB.add(a.mul(RAY)).div(b);
    }

    function rayToWad(uint256 a) internal pure returns (uint256) {
        uint256 halfRatio = WAD_RAY_RATIO / 2;

        return halfRatio.add(a).div(WAD_RAY_RATIO);
    }

    function wadToRay(uint256 a) internal pure returns (uint256) {
        return a.mul(WAD_RAY_RATIO);
    }

    function simpleToWay(uint256 a) internal pure returns (uint256) {
        return a.mul(WAD);
    }

    function simpleToRay(uint256 a) internal pure returns (uint256) {
        return a.mul(RAY);
    }

    function rayToSimple(uint256 a) internal pure returns (uint256) {
        if (a < RAY) return 0;
        return a.div(RAY);
    }

    /**
     * @dev calculates base^exp. The code uses the ModExp precompile
     * @return z base^exp, in ray
     */
    //solium-disable-next-line
    function rayPow(uint256 x, uint256 n) internal pure returns (uint256 z) {
        z = n % 2 != 0 ? x : RAY;

        for (n /= 2; n != 0; n /= 2) {
            x = rayMul(x, x);

            if (n % 2 != 0) {
                z = rayMul(z, x);
            }
        }
    }

    function ray2int128(uint256 X) internal pure returns (int128) {
        uint256 result = X.div(RAY);
        uint256 decimalPart = X.sub(result.mul(RAY));
        uint256 rayCursor = RAY >> 1;
        uint64 decimalResult = 0x0000000000000000;
        uint64 cursor = 0x8000000000000000;
        while (cursor > 0 && decimalPart > 0 && rayCursor > 0) {
            if (decimalPart >= rayCursor) {
                decimalResult = decimalResult | cursor;
                decimalPart = decimalPart.sub(rayCursor);
            }
            cursor = cursor >> 1;
            rayCursor = rayCursor >> 1;
        }
        return int128((result << 64) | uint256(decimalResult));
    }

    function int128ToRay(int128 X) internal pure returns (uint256) {
        uint256 result = (uint256(X) >> 64).mul(RAY);

        uint256 rayCursor = RAY >> 1;
        uint64 decimalPart = uint64(X);
        uint64 cursor = 0x8000000000000000;
        while (decimalPart > 0 && cursor > 0 && rayCursor > 0) {
            if (decimalPart >= cursor) {
                result = result.add(rayCursor);
                decimalPart = decimalPart - cursor;
            }
            cursor = cursor >> 1;
            rayCursor = rayCursor >> 1;
        }
        return result;
    }

    function rayPower2(uint256 n) internal pure returns (uint256 z) {
        uint256 integerPart = n.div(RAY);
        uint256 result = ray();
        if (integerPart > 0) {
            result = rayPow(simpleToRay(2), integerPart);
        }
        uint256 decimalPart = n.sub(integerPart.mul(RAY));
        uint256 rayCursor = RAY.div(2);
        uint256[62] memory rooti = [
            (uint256)(1414213562373095048801688724),
            1189207115002721066717499970,
            1090507732665257659207010655,
            1044273782427413840321966478,
            1021897148654116678234480134,
            1010889286051700460020409790,
            1005429901112802821351383955,
            1002711275050202485430745588,
            1001354719892108205880881526,
            1000677130693066356678172784,
            1000338508052682312890468978,
            1000169239705302231017384333,
            1000084616272694313125410361,
            1000042307241395819295080159,
            1000021153396964808022194520,
            1000010576642549720179347494,
            1000005288307291763047219408,
            1000002644150150116512595902,
            1000001322074201118121627990,
            1000000661036882074162671771,
            1000000330518386415870352853,
            1000000165259179552598549347,
            1000000082629586362471894166,
            1000000041314792327779101953,
            1000000020657395950491458373,
            1000000010328697921902982296,
            1000000005164348947615804419,
            1000000002582174470446875469,
            1000000001291087234356075992,
            1000000000645543616934092504,
            1000000000322771808412836139,
            1000000000161385904152207956,
            1000000000080692952048998918,
            1000000000040346475997394400,
            1000000000020173237971592142,
            1000000000010086618931585959,
            1000000000005043309411582868,
            1000000000002521654651581323,
            1000000000001260827271580552,
            1000000000000630413581580166,
            1000000000000315206736579973,
            1000000000000157603314079877,
            1000000000000078801602829828,
            1000000000000039400774309858,
            1000000000000019700332944816,
            1000000000000009850139367352,
            1000000000000004925042578619,
            1000000000000002462494184253,
            1000000000000001231219987070,
            1000000000000000615555783424,
            1000000000000000307750786656,
            1000000000000000153848288272,
            1000000000000000076869934026,
            1000000000000000038380756903,
            1000000000000000019136168341,
            1000000000000000009540979115,
            1000000000000000004716279447,
            1000000000000000002331034668,
            1000000000000000001138412279,
            1000000000000000000542101085,
            1000000000000000000216840434,
            1000000000000000000054210108
        ];
        uint256 index = 0;
        while (decimalPart > 0 && rayCursor > 0 && index < 62) {
            if (decimalPart >= rayCursor) {
                decimalPart = decimalPart.sub(rayCursor);
                result = rayMul(result, rooti[index]);
            }
            rayCursor >>= 1;
            index = index + 1;
        }
        return result;
    }

    /**
     * Calculate binary logarithm of x.  Revert if x <= 0.
     *
     * @param x signed 64.64-bit fixed point number
     * @return signed 64.64-bit fixed point number
     */
    function log_2(int128 x) internal pure returns (int128) {
        require(x > 0);

        int256 msb = 0;
        int256 xc = x;
        if (xc >= 0x10000000000000000) {
            xc >>= 64;
            msb += 64;
        }
        if (xc >= 0x100000000) {
            xc >>= 32;
            msb += 32;
        }
        if (xc >= 0x10000) {
            xc >>= 16;
            msb += 16;
        }
        if (xc >= 0x100) {
            xc >>= 8;
            msb += 8;
        }
        if (xc >= 0x10) {
            xc >>= 4;
            msb += 4;
        }
        if (xc >= 0x4) {
            xc >>= 2;
            msb += 2;
        }
        if (xc >= 0x2) msb += 1; // No need to shift xc anymore

        int256 result = (msb - 64) << 64;
        uint256 ux = uint256(x) << uint256(127 - msb);
        for (int256 bit = 0x8000000000000000; bit > 0; bit >>= 1) {
            ux *= ux;
            uint256 b = ux >> 255;
            ux >>= 127 + b;
            result += bit * int256(b);
        }

        return int128(result);
    }
}
