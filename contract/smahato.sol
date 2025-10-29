// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title QuoteStorage
 * @dev A smart contract to store and retrieve inspirational or famous quotes.
 * Demonstrates the use of structs, dynamic arrays, and public functions.
 */
contract QuoteStorage {
    // -------------------------------------------------------------------------
    // 1. STATE VARIABLES & STRUCT (Data stored on the blockchain)
    // -------------------------------------------------------------------------

    // 1a. Define a custom data structure (struct) for a Quote
    struct Quote {
        string text; // The content of the quote.
        address author; // The address that submitted the quote.
        uint256 timestamp; // The time the quote was added.
    }

    // 1b. A dynamic array to store all submitted Quote structs.
    Quote[] public allQuotes;

    // A state variable to store the address that deployed this contract (Owner).
    address private immutable owner;

    // -------------------------------------------------------------------------
    // 2. EVENTS (Notifications for external applications)
    // -------------------------------------------------------------------------

    // Event emitted when a new quote is successfully added.
    event QuoteAdded(address indexed submitter, uint256 index, string quoteText);

    // -------------------------------------------------------------------------
    // 3. CONSTRUCTOR (Executed only once upon deployment)
    // -------------------------------------------------------------------------

    constructor() {
        owner = msg.sender;
    }

    // -------------------------------------------------------------------------
    // 4. FUNCTIONS (Logic executed by users)
    // -------------------------------------------------------------------------

    /**
     * @dev Allows any user to submit a new quote.
     * @param _quoteText The content of the quote to be stored.
     */
    function addQuote(string memory _quoteText) public {
        // Safety check: ensure the quote is not empty
        require(bytes(_quoteText).length > 0, "Quote text cannot be empty");

        // Create a new Quote struct and add it to the dynamic array.
        // The current index of the new quote is equal to the current length of the array.
        uint256 newIndex = allQuotes.length;

        allQuotes.push(
            Quote({
                text: _quoteText,
                author: msg.sender,
                timestamp: block.timestamp // Global variable for current block timestamp
            })
        );

        // Emit an event to notify off-chain listeners.
        emit QuoteAdded(msg.sender, newIndex, _quoteText);
    }

    /**
     * @dev Retrieves the total number of quotes stored in the contract.
     * @return The number of quotes.
     */
    function getTotalQuotes() public view returns (uint256) {
        // 'view' means the function only reads state, costing zero gas to execute off-chain.
        return allQuotes.length;
    }

    /**
     * @dev Allows the owner to remove all quotes. (Administrative cleanup)
     * NOTE: This is expensive in gas and generally avoided in production.
     */
    function clearAllQuotes() public onlyOwner {
        // Deleting the entire dynamic array effectively resets the contract's quote storage.
        delete allQuotes;
    }

    // --- Utility Functions (Kept from template) ---

    // Restricts access to a function only to the 'owner' address.
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the contract owner");
        _;
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}

