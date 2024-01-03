// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DAOMembership {

    struct Applicant {
        bool isApplicant;
        uint votes;
    }

    mapping(address => bool) public userIsMember;
    mapping(address => Applicant) public applicants;
    mapping(address => mapping(address => bool)) public approvals;

    address[] public members;

    constructor() {
        members.push(msg.sender);
        userIsMember[msg.sender] = true;
    }


    //To apply for membership of DAO
    function applyForEntry() public{
        require (!userIsMember[msg.sender] && !applicants[msg.sender].isApplicant, "Already a member or already applied");
        Applicant memory newApplicant = Applicant({isApplicant:true,votes:0});
        applicants[msg.sender] = newApplicant;
    }
    
    //To approve the applicant for membership of DAO
    function approveEntry(address _applicant) public {
        require (applicants[_applicant].isApplicant && userIsMember[msg.sender] && !userIsMember[_applicant] && !approvals[msg.sender][_applicant], "Invalid applicant or already voted");
        applicants[_applicant].votes ++;
        approvals[msg.sender][_applicant] = true;

        if (applicants[_applicant].votes > (members.length*3)/10) {
            members.push(_applicant);
            userIsMember[_applicant]=true;
        }
    }

        
    
    //To check membership of DAO
    function isMember(address _user) public view returns (bool) {
        require (userIsMember[msg.sender], "You are not a member");
        return userIsMember[_user];
    }
    
