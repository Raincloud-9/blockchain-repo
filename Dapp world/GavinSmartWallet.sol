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
