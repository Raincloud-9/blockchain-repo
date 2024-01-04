// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract TicketBooking {

    uint numSeatAvailable = 20;

    mapping(address => uint[]) public addressToSeats;
    mapping(uint => bool) public seatTaken;


    //To book seats
    function bookSeats(uint[] memory seatNumbers) public {
        require(seatNumbers.length > 0 && seatNumbers.length <5, "Invalid input");
        require(addressToSeats[msg.sender].length + seatNumbers.length <5);

        for(uint i=0; i<seatNumbers.length; i++){
            uint seat = seatNumbers[i];
            require(seat > 0 && seat <=20, "Invalid seat");
            require(checkAvailability(seat), "Seat already booked");

            addressToSeats[msg.sender].push(seatNumbers[i]);
            seatTaken[seatNumbers[i]] = true;
            numSeatAvailable--;
        }

    }

    //To get available seats
    function showAvailableSeats() public view returns (uint[] memory) {
        uint256[] memory availableSeats = new uint256[](numSeatAvailable);
        uint arrayIndex;

        for(uint seat=1; seat<=20; seat++){
            if(!seatTaken[seat]){
                availableSeats[arrayIndex] = seat;
                arrayIndex++;
            }
        }
        
        return availableSeats;
    }
    
    //To check availability of a seat
    function checkAvailability(uint seatNumber) public view returns (bool) {
        require(seatNumber>0 && seatNumber<=20, "Not valid seat");
        if (seatTaken[seatNumber] == true) {
            return false;
        } else {return true;}
    }

    
    //To check tickets booked by the user
    function myTickets() public view returns (uint[] memory) {
        return addressToSeats[msg.sender];
    }
}
