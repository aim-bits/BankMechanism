// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract BankMechanism {
    mapping (address => uint256) public balances;
    address payable owner;
    

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Only Owner can call this function");
        _;
    }


    function deposit() public payable {
        require(msg.value > 0);
        balances[msg.sender] += msg.value;
    }


    function withdraw(uint256 _amount)public onlyOwner{
        require(_amount <= balances[msg.sender]);
        require(_amount > 0);

        payable(msg.sender).transfer(_amount);
        balances[msg.sender] -= _amount;
    }


    event Transfer(address indexed from, address indexed  to, uint256 indexed amount );
    function transfer(address payable _receipient, uint256 _amount) public payable onlyOwner  {
        require(_receipient != address(0));
        require(_amount > 0);
        require(balances[msg.sender] >= _amount);

        _receipient.transfer(_amount);
        balances[msg.sender] -= _amount;
        balances[_receipient] += _amount;
        emit Transfer(msg.sender, _receipient, _amount);
    }


    function getBalance(address payable _user) public view returns (uint256) {
        return balances[_user]; 
    }
}



