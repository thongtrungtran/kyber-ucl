using MaliciousReceiver as Receiver;
using UnsafeBank as Bank;
methods{
  
  function totalFunds() external returns uint256 envfree;
  function balanceOf(address) external returns uint256 envfree;

  function Receiver.bank() external returns (address) envfree;
  function Receiver.reenter() external returns bool envfree;

  // function _.withdraw(uint256,address) external => DISPATCHER(true);
  function _.withdraw(uint256,address) external => DISPATCHER(true);
  function _.sendFund() external => DISPATCHER(true);
}


rule maximumWithdrawAmountEQBalance(){
  env e;

  uint256 amount;

  uint256 totalFundsBefore = totalFunds();

  require amount <= balanceOf(e.msg.sender);
  require e.msg.sender != currentContract;
  require Receiver.bank() == currentContract;

  withdraw(e, amount, e.msg.sender);
  
  uint256 totalFundsAfter = totalFunds();
  assert assert_uint256(totalFundsBefore - totalFundsAfter) == amount,"exceeds";
}