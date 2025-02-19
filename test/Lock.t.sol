// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/BridgeEth.sol";
import "src/USDT.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract BridgeETHTest is Test {
    event Transfer(address indexed from, address indexed to, uint256 value);

    BridgeETH bridge;
    USDT usdt;

    function setUp() public {
        usdt = new USDT();
        bridge = new BridgeETH(address(usdt));
    }

    function test_Withdraw() public {}

    function test_Deposit() public {
        usdt.mint(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd, 200);

        vm.startPrank(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd);
        usdt.approve(address(bridge), 200);

        // this will save the token in the contract itself
        bridge.deposit(usdt, 200);

        assertEq(usdt.balanceOf(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd), 0);
        assertEq(usdt.balanceOf(address(bridge)), 200);

        bridge.withdraw(usdt, 100);

        assertEq(
            usdt.balanceOf(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd),
            100
        );
        assertEq(usdt.balanceOf(address(bridge)), 100);
    }
}
