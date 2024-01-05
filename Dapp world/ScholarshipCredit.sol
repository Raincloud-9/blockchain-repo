// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

error NotOwner();
error NotAStudent();
error NotAMerchant();
error NotAuthorized();

contract ScholarshipCreditContract {

    address public owner;

    mapping(address => uint) public studentBalances;
    mapping(address => bool) public listOfStudents;
    mapping(address => uint) public merchantBalances;
    mapping(address => bool) public listOfMerchants;

    uint256 public gavinBalance = 1000000;
    
    constructor(){
        owner = msg.sender;
    }
