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

    //This function assigns credits to student getting the scholarship
    function grantScholarship(address studentAddress, uint credits) public {
        if(msg.sender != owner) revert NotOwner();
        if(studentAddress == owner) revert NotAuthorized();
        if(listOfMerchants[studentAddress]) revert NotAuthorized();

        gavinBalance -= credits;
        studentBalances[studentAddress] += credits;
        listOfStudents[studentAddress] = true;
    }

    //This function is used to register a new merchant who can receive credits from students
    function registerMerchantAddress(address merchantAddress) public {
        if(msg.sender != owner) revert NotOwner();
        if(merchantAddress == owner) revert NotAuthorized();
        if(listOfStudents[merchantAddress]) revert NotAuthorized();        

        listOfMerchants[merchantAddress] = true;
    }

    //This function is used to deregister an existing merchant
    function deregisterMerchantAddress(address merchantAddress) public {
        if(msg.sender != owner) revert NotOwner();
        gavinBalance += merchantBalances[merchantAddress];
        merchantBalances[merchantAddress] = 0;
        listOfMerchants[merchantAddress] = false;
    }

    //This function is used to revoke the scholarship of a student
    function revokeScholarship(address studentAddress) public{
        if(msg.sender != owner) revert NotOwner();
        gavinBalance += studentBalances[studentAddress];
        studentBalances[studentAddress] = 0;
        listOfStudents[studentAddress] = false;
    }

    //Students can use this function to transfer credits only to registered merchants
    function spend(address merchantAddress, uint amount) public {
        if(listOfStudents[msg.sender] != true) revert NotAStudent();
        if(listOfMerchants[merchantAddress] != true) revert NotAMerchant();
        merchantBalances[merchantAddress] += amount;
        studentBalances[msg.sender] -= amount;
    }

    //This function is used to see the available credits assigned.
    function checkBalance() public view returns (uint) {
        if (!(msg.sender == owner || listOfStudents[msg.sender] || listOfMerchants[msg.sender])) revert NotAuthorized();
        if (msg.sender == owner) return gavinBalance;
        if (listOfMerchants[msg.sender]) return merchantBalances[msg.sender];
        if (listOfStudents[msg.sender]) return studentBalances[msg.sender];
        else {return 0;}
    }
}
