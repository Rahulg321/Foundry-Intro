//SPDX-License-Identifier:MIT
pragma solidity ^0.8.7;

contract MyToken {
    string errorMsg = "Function caller is not the owner";
    address private owner;
    uint public totalSupply;
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowances;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, errorMsg);
        _;
    }

    function getOwner() public view onlyOwner returns (address) {
        return owner;
    }

    function mint(uint _amount) public onlyOwner {
        // create some new tokens for yourself
        balances[msg.sender] += _amount;
        totalSupply += _amount;
    }

    function mintTo(address _to, uint _amount) public onlyOwner {
        // create some new tokens for someone else
        balances[_to] += _amount;
        totalSupply += _amount;
    }

    function transfer(address _to, uint _amount) public {
        require(
            balances[msg.sender] >= _amount,
            "does not have balance to send eth"
        );
        balances[_to] += _amount;
    }

    function burn(uint _amount) public {
        // burn your money for nothing
        require(balances[msg.sender] >= _amount, "do not have enough balance");
        balances[msg.sender] -= _amount;
        totalSupply -= _amount;
    }

    function mintFrom() public {}

    function approve(
        address _spender,
        uint value
    ) public returns (bool success) {
        // who should we allow to spend all of our money
        // allowances[person with balance][person who is allowed to spend]
        allowances[msg.sender][_spender] = value;
        return true;
    }

    function transferFrom(address _from, address _to, uint _value) public {
        // using the allowances array, allow the other person to transfer money to someone else
        // provided they have the necessary allowance
        uint allowance = allowances[_from][msg.sender];
        require(
            allowance >= _value,
            "You dont have enough allowance to send to that person"
        );

        require(
            balances[_from] >= _value,
            "from account does not enough balance"
        );

        balances[_from] -= _value;
        balances[_to] += _value;
        allowances[_from][msg.sender] -= _value;
    }

    function allow() public {}
}
