// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// this function essentially locks the contract on behalf of the user.....
contract BridgeETH is Ownable {
    uint256 public amount;
    address public tokenAddress;

    mapping(address => uint256) public pendingBalance;

    constructor(address _tokenAddress) Ownable(msg.sender) {
        tokenAddress = _tokenAddress;
    }

    // expect a token instance as an arguement
    function withdraw(IERC20 _tokenAddress, uint256 _amount) public {
        require(pendingBalance[msg.sender] >= _amount);
        pendingBalance[msg.sender] -= _amount;
        _tokenAddress.transfer(msg.sender, _amount);
    }

    function deposit(IERC20 _tokenAddress, uint256 _amount) public {
        require(address(_tokenAddress) == tokenAddress);
        require(_tokenAddress.allowance(msg.sender, address(this)) >= _amount);

        // transfer tokens from the owners address to the contract.....
        require(
            _tokenAddress.transferFrom(msg.sender, address(this), _amount),
            "transfer of tokens from owner to the contract failed!!!!!"
        );

        pendingBalance[msg.sender] += _amount;
    }
}
