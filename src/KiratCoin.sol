// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract KiratCoin is ERC20{
    constructor(uint256 _initialValue) ERC20("KiratCoin","KRC"){}
}