// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

contract Counter {
    uint256 public counter;

    constructor(uint256 _value){
        counter = _value;
    }

    // function counter() public view returns (uint256) {
    //     return counter;
    // }

    function increment() public {
        counter++;
    }


    function decrement() public {
        counter--;
    }

 }
