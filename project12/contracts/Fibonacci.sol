pragma solidity ^0.5.2;

contract Fibonacci {
    //external can only be called out this smart contract where as public can be called within and outside the smartcontract
    function fib(uint256 n) external pure returns (uint256) {
        if (n == 0) {
            return 0;
        }
        uint256 fi_1 = 1;
        uint256 fi_2 = 1;

        //* imp: using RECURSSION to compute fibonacci will comsume too much gas and might fail */
        for (uint256 i = 2; i < n; i++) {
            uint256 fi = fi_1 + fi_2;
            fi_2 = fi_1;
            fi_1 = fi;
        }
        return fi_1;
    }
}
