// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Counter.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TestContract is Test {
    Counter c;
    uint testNumber;

    function setUp() public {
        c = new Counter(5);
        testNumber = 42;
    }


    function test_Increment() public {
        c.increment();
        c.increment();
        // Call the getter function for counter
        assertEq(c.counter(), uint256(7), "Counter should be 7 after two increments");
    }


    function test_Decrement() public {
        c.decrement();
        c.decrement();
        // Call the getter function for counter
        assertEq(c.counter(), uint256(3), "Counter should be 3 after two increments");
    }

    function test_Fail_Decrement() public {
        c.decrement();
        c.decrement();
        c.decrement();
        c.decrement();
        c.decrement();
        vm.expectRevert(stdError.arithmeticError);
        c.decrement();
        // Call the getter function for counter
    }


    function test_Bar() public {
        assertEq(uint256(1), uint256(1), "ok");
    }

    function test_Equal() public {
        assertEq(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd, 0x4F781660940951CCAd15EC34b121F1Dd3F244Edd, "ok");
    }

    function test_NumberIs42() public {
        assertEq(testNumber, 42);
    }


}
