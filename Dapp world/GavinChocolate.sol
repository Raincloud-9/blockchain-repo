// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract ChcolateShop  {

    uint public numOfChocolates;

    //this function allows gavin to buy n chocolates
    function buyChocolates(uint n) public {
        numOfChocolates += n;
    }

    //this function allows gavin to sell n chocolates
    function sellChocolates(uint n) public {
        numOfChocolates -= n;
    }

    //this function returns total number of chocolates in bag
    function chocolatesInBag() public view returns(uint) {
        return numOfChocolates;
    }


}
