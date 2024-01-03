// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MyContract {
    function Greater(uint[] memory nums) public pure returns(uint){
        uint greatest = nums[0];
        for(uint i=1; i<nums.length; i++){
            if (greatest<nums[i]) greatest=nums[i];
        }
        return greatest;
    }
}
