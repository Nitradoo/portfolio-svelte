// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;


contract MessageBoard {
	uint256 public totalMessages; // an integer public variable

	address payable public owner; // identify the owner (the address) of the contract

	/*
	 * Store the "Tip" data in a structure
	 * the struct allow you to create a custom datatype
	 */
	struct Message {
		address sender; //The person who gives you the tip
		string message; //A message from the sender;
		string name; //THe name of the sender
		uint256 timestamp; //When the tip was sent
	}
	/*
    store an array of structs to hold all the messages sent
    */
	Message[] messages;

	/*
	 * Solidity magic, this defines an Event that can be trigger and sent to the clients
	 * it will hold the address that trigger the event and will index that to allow for future search
	 * it can also hold more information,. in this case the message, name and amount same as the struct above
	 */
	event NewMessage(address indexed from, string message, string name);

	/*
	 * Constructor
	 * it is called when the contract is deployed
	 * it will set the owner of the contract
	 */
	constructor() {
		owner = payable(msg.sender); // set the contract createor based in who instantitiated it
	}

	// Functions

	/*
	 * public funtion (like a getter) that returns the total number of messages
	 * is marked as public and as a view, meaning that only reads from the blockchain so is gas free
	 * In a function you should declare what it returns
	 */
	function getTotalMessages() public view returns (uint256) {
		return totalMessages;
	}

	function sendMessage(string memory _message, string memory _name) public {
		totalMessages += 1;
		messages.push(Message(msg.sender, _message, _name, block.timestamp));

		// send the event
		emit NewMessage(msg.sender, _message, _name);
	}

	/*
	 * a function that give access to the stored tips struct
	 * is just read from the blockchain so is marked as view
	 */
	function getAllMessages() public view returns (Message[] memory) {
		return messages;
	}

	/**
	 * A modifier function that ensure that an action is made only by the owner of the contract
	 * Throws if called by any account other than the owner.
	 */

	modifier onlyOwner() {
		require(owner == msg.sender, 'caller is not the owner');
		_;
	}

	/*
	 * Allow the owner to withdraw all the ether in the contract
	 */
}
