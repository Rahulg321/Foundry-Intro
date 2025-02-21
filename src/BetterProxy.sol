// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract BetterProxy {
    uint public num;
    address implementation;

    constructor(address _implementationAddrress) {
        implementation = _implementationAddrress;
    }

    // a default function is called if the called function is not defined
    fallback() external {
        (bool success, ) = implementation.delegatecall(msg.data);

        if (!success) {
            revert();
        }
    }
}

contract Implementationv1 {
    uint public num;

    function setNum(uint _num) public {
        num = _num;
    }
}
