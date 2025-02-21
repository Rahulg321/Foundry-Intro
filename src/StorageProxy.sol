// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract StorageProxy is Ownable {
    uint public num;
    address public implementation;

    constructor(address _implementationContractAddress) Ownable(msg.sender) {
        implementation = _implementationContractAddress;
    }

    function setNum(uint _num) public {
        (bool success, ) = implementation.delegatecall(
            abi.encodeWithSignature("setNum(uint256)", _num)
        );
        require(success, "Error while delegating call");
    }

    function setNewImplementationVersionAddress(
        address _implementationContractAddress
    ) public onlyOwner {
        implementation = _implementationContractAddress;
    }
}

contract Implementationv1 {
    uint public random;
    uint public num;

    function setNum(uint _num) public {
        num = _num;
    }
}

contract Implementationv2 {
    uint public random;
    uint public num;

    function setNum(uint _num) public {
        num = _num * 2;
    }
}

contract Implementationv3 {
    uint public random;
    uint public num;

    function setNum(uint _num) public {
        num = _num * 3;
    }
}
