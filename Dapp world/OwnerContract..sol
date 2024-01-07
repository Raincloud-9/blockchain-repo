// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MyContract {

    uint private num;
    address private owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender == owner, "You are not the owner");
        _;
    }


    function get_owner() public view returns(address){
        return(owner);
    }

    function change_owner(address _newOwner) public onlyOwner{
        owner = _newOwner;
    }

    function store(uint number) public onlyOwner{
        num = number;
    }

    function retrieve() public view returns(uint){
        return(num);
    }
    
}
