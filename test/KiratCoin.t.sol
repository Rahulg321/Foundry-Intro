// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/KiratCoin.sol";

contract KiratCoinTestContract is Test {
    KiratCoin c;

    function setUp() public {
        c = new KiratCoin(5);
    }

    function test_Simple() public {
        assertEq(uint(2), uint(2), "ok");
    }

}
