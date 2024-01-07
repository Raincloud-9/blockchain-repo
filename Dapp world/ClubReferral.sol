// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

error ReferrerNotAMember();
error IncorrectPayment();

contract MyContract {

    address[] public members;

    mapping(address => bool) public isMember;

    function join() public payable{
        if(msg.value != 1 ether) revert IncorrectPayment();
        members.push(msg.sender);
        isMember[msg.sender] = true;
    }

    function join_referrer(address payable referrer) public payable{
        if(isMember[referrer] != true) revert ReferrerNotAMember();
        join();
        referrer.transfer(0.1 ether);
        
    }
    
    function get_members() public view returns(address[] memory){
        return (members);
    }
}
