// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/KiratCoin.sol";

contract KiratCoinTestContract is Test {
    KiratCoin c;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed to, uint256 amount);

    function setUp() public {
        c = new KiratCoin(100);
    }

    function test_ExpectEmitApprove() public {
        c.mint(address(this), 100);

        // we care about values other than the indexed field also
        vm.expectEmit(true, true, false, true);
        emit Approval(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd, 100);

        c.approve(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd, 100);

        vm.prank(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd);
        c.transferFrom(
            address(this),
            0x4F781660940951CCAd15EC34b121F1Dd3F244Edd,
            100
        );
    }

    function test_TransferEmit() public {
        c.mint(address(this), 100);
        // Check that topic 1, topic 2, and data are the same as the following emitted event.
        // Checking topic 3 here doesn't matter, because `Transfer` only has 2 indexed topics.
        // we can index max 3 parameters from events, in our code we only have two
        vm.expectEmit(true, true, false, true);

        emit Transfer(
            address(this),
            0x4F781660940951CCAd15EC34b121F1Dd3F244Edd,
            100
        );
        c.transfer(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd, 100);
    }

    function test_Mint() public {
        // test minting logic
        c.mint(address(this), 200);
        assertEq(c.balanceOf(address(this)), 300, "ok");
        assertEq(
            c.balanceOf(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd),
            0,
            "ok"
        );
    }

    function test_CheckTrasfer() public {
        c.mint(address(this), 100);
        c.transfer(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd, 50);

        assertEq(c.balanceOf(address(this)), 150, "ok");
        assertEq(
            c.balanceOf(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd),
            50,
            "ok"
        );

        // check if the person we sent the token to can send the token back to us

        // this is a "cheatcode"  which changes the address of the person who called the function
        vm.prank(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd);
        c.transfer(address(this), 50);

        assertEq(c.balanceOf(address(this)), 200, "ok");
        assertEq(
            c.balanceOf(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd),
            0,
            "ok"
        );
    }

    function test_Approvals() public {
        c.mint(address(this), 100);

        c.approve(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd, 50);

        assertEq(
            c.allowance(
                address(this),
                0x4F781660940951CCAd15EC34b121F1Dd3F244Edd
            ),
            50,
            "ok"
        );

        vm.prank(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd);

        c.transferFrom(
            address(this),
            0x4F781660940951CCAd15EC34b121F1Dd3F244Edd,
            25
        );

        assertEq(c.balanceOf(address(this)), 175, "ok");
        assertEq(
            c.balanceOf(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd),
            25,
            "ok"
        );

        assertEq(
            c.allowance(
                address(this),
                0x4F781660940951CCAd15EC34b121F1Dd3F244Edd
            ),
            25,
            "ok"
        );
    }

    function test_Fail_Approvals() public {
        c.mint(address(this), 100);
        c.approve(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd, 50);

        vm.prank(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd);
        vm.expectRevert();
        c.transferFrom(
            address(this),
            0x4F781660940951CCAd15EC34b121F1Dd3F244Edd,
            200
        );
    }

    function test_Fail_Transfer() public {
        c.mint(address(this), 100);
        vm.expectRevert();
        c.transfer(0x4F781660940951CCAd15EC34b121F1Dd3F244Edd, 300);
    }
}
