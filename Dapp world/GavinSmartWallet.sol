// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

error LimitReached();
error NotGavinOrAuthorized();

contract SmartWallet {

    uint balance;
    address gavin;

    mapping(address => bool) isAuthorized;

    constructor(){
        gavin = msg.sender;
    }

    //this function allows adding funds to wallet
    function addFunds(uint amount) public {
        if(balance>= 10000) revert LimitReached();
        if(msg.sender != gavin && !isAuthorized[msg.sender]) revert NotGavinOrAuthorized();
        balance += amount;
    }

    //this function allows spending an amount to the account that has been granted access by Gavin
    function spendFunds(uint amount) public {
        if(msg.sender != gavin && !isAuthorized[msg.sender]) revert NotGavinOrAuthorized();
        balance -= amount;
    }

    //this function grants access to an account and can only be accessed by Gavin
    function addAccess(address x) public {
        if(msg.sender != gavin) revert NotGavinOrAuthorized();
        isAuthorized[x] = true;
    }

    //this function revokes access to an account and can only be accessed by Gavin
    function revokeAccess(address x) public {
        if(msg.sender != gavin) revert NotGavinOrAuthorized();
        isAuthorized[x] = false;
    }

    //this function returns the current balance of the wallet
    function viewBalance() public view returns(uint) {
        if(msg.sender != gavin && !isAuthorized[msg.sender]) revert NotGavinOrAuthorized();
        return(balance);
    }

}
