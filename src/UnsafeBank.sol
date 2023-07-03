pragma solidity 0.8.9;

contract MaliciousReceiver {
    bool public reenter;
    UnsafeBank public bank;

    function sendFund() external payable {
        if (reenter) {
            reenter = false;
            UnsafeBank(bank).withdraw(msg.value, address(this));
        }
    }
}

contract UnsafeBank {
    mapping(address => uint256) public balanceOf;

    function deposit() public payable {
        balanceOf[msg.sender] = msg.value;
    }

    // @note reentrancy available
    function withdraw(uint256 amount, address receiver) public virtual {
        require(balanceOf[msg.sender] >= amount);
        MaliciousReceiver(receiver).sendFund{value: amount}();
        unchecked {
            balanceOf[msg.sender] -= amount;
        }
    }

    function totalFunds() public view returns (uint256) {
        return address(this).balance;
    }
}

contract SafeBank is UnsafeBank {
    bool LOCK = false;

    function withdraw(uint256 amount, address receiver) public override {
        require(!LOCK);
        LOCK = true;
        super.withdraw(amount, receiver);
        LOCK = false;
    }
}
