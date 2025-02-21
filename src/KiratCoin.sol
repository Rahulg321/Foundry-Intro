// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import {console} from "forge-std/console.sol";

contract KiratCoin is ERC20, Ownable {
    constructor(
        uint256 _initialValue
    ) Ownable(msg.sender) ERC20("KiratCoin", "KRC") {
        // mint myself some new tokens
        _mint(msg.sender, _initialValue);
    }

    function test() public payable {}

    function getBalance() public view returns (uint256) {
        // returns the contract's balance
        // this refers to the instance of the contract
        return address(this).balance;
    }

    function mint(address _account, uint256 _amount) public onlyOwner {
        console.logString("minting function called");
        console.logAddress(_account);
        console.logUint(_amount);
        _mint(_account, _amount);
        console.log("minting function ended");
    }
}
