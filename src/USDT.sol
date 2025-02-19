// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// creating a token contract
contract USDT is Ownable, ERC20 {
    constructor() Ownable(msg.sender) ERC20("USDT", "UDT") {}

    function mint(address _to, uint256 _amount) public {
        _mint(_to, _amount);
    }
}
