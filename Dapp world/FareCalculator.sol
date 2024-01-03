// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MyContract {
    uint public finalfare;

// Set distance from A to each stop (B,C,D,E)   
    uint[] public distFromA = [0, 2, 7, 18, 41];


// This function checks which stop is further first and then calculates
// the difference between the two stops

    function calculatefare(uint index1, uint index2) public {
        if (distFromA[index1] > distFromA[index2]) finalfare = distFromA[index1]-distFromA[index2];
        else finalfare = distFromA[index2]-distFromA[index1];
    }
}

// Ways the code could be impoved:
// Make it an external function to save gas since it only needs to be called externally
// 
