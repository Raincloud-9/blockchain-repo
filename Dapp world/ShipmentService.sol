// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

error NotFourDigits();
error NotTheOwner();
error NotCustomer();
error CannotShipToOwner();
error OrderInProgress();
error NotRecipient();

contract ShipmentService {

    address public owner;

    mapping (address => uint) orderPin;
    mapping (address => bool) orderIsComplete;
    mapping (address => bool) orderInProgress;
    mapping (address => bool) orderExists;
    mapping (address => uint) numOfDeliveries;

    constructor() {
        owner = msg.sender;
    }

    //This function inititates the shipment
    function shipWithPin(address customerAddress, uint pin) public {
        if (msg.sender != owner) revert NotTheOwner();
        if (msg.sender == customerAddress) revert CannotShipToOwner();
        if (orderInProgress[customerAddress]) revert OrderInProgress();
        if (pin<1000 || pin>9999) revert NotFourDigits();
        orderPin[customerAddress] = pin;
        orderIsComplete[customerAddress] = false;
        orderInProgress[customerAddress] = true;
        orderExists[customerAddress] = true;
    }
        

    //This function acknowlegdes the acceptance of the delivery
    function acceptOrder(uint pin) public {
        if (msg.sender == owner) revert NotCustomer();
        if (orderPin[msg.sender] == pin) {
            orderIsComplete[msg.sender] = true;
            numOfDeliveries[msg.sender]++;
            orderInProgress[msg.sender] = false;
        } else {revert NotRecipient();}
    }

    //This function outputs the status of the delivery
    function checkStatus(address customerAddress) public view returns (string memory){
        if (msg.sender != customerAddress && msg.sender !=owner) revert NotRecipient();
        if (orderExists[customerAddress]) {
            return orderIsComplete[customerAddress] == true ? "delivered" : "shipped";
        } else { 
            return "no orders placed";
        }
    }

    //This function outputs the total number of successful deliveries
    function totalCompletedDeliveries(address customerAddress) public view returns (uint) {
        if (msg.sender != customerAddress && msg.sender !=owner) revert NotRecipient();
        return numOfDeliveries[customerAddress];
    }
}
