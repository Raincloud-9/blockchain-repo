// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Fibonacci {
    //To find the value of n+1 th Fibonacci number
    function fibonacci(uint n) public pure returns (uint) {
        uint current = 1;
        uint previous = 0;
        uint sum;

        if(n==1){
            return previous;
        }

        if(n==2){
            return current;
        } else {
            for(uint i=1; i<n; i++){
                sum = current + previous;
                previous = current;
                current = sum;
            }
            return current;
        }
    }
}
