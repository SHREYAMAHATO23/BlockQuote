<img width="1920" height="1200" alt="Screenshot 2025-10-29 135344" src="https://github.com/user-attachments/assets/cb18d719-9c53-47f6-8e46-65329a13cb76" />
# BlockQuoteBlockQuote Smart Contract: QuoteStorage

This repository contains the Solidity smart contract for BlockQuote, a simple, decentralized application designed to permanently store inspirational or famous quotes on the Ethereum blockchain. This contract serves as a foundational example for beginners learning about state management, structs, and arrays in Solidity.

📄 Contract Overview

File: QuoteStorage.sol

Purpose: To provide a single, immutable storage location for user-submitted text quotes.

Technology: Solidity (^0.8.0), Ethereum Virtual Machine (EVM).

Key Features

Permanent Storage: Quotes, once added, are immutable and stored permanently on the blockchain.

Custom Data Structure: Uses a struct to group related information for each quote.

Simple Access Control: Includes an onlyOwner modifier for administrative functions.

⚙️ Data Structure

The core of the contract relies on the following custom struct and state array:

struct Quote

A blueprint defining the data fields for a single quote entry:

Field

Type

Description

text

string

The content of the quote itself.

author

address

The blockchain address that submitted the quote (msg.sender).

timestamp

uint256

The Unix timestamp of the block when the quote was added (block.timestamp).

Quote[] public allQuotes

A dynamic, public array that holds every submitted Quote struct. The public visibility automatically creates a getter function to access quotes by their numerical index (ID).

🚀 Functions and Usage

Function

Type / Visibility

Description

constructor()

internal

Sets the contract owner to the address that deploys the contract.

addQuote(string memory _quoteText)

public

Allows any user to submit a quote. Requires the _quoteText to not be empty. Emits a QuoteAdded event upon success.

getTotalQuotes()

public view

Returns the total count of quotes stored in the allQuotes array. This is a gas-free read operation (view).

allQuotes(uint256 index)

public view

(Auto-generated Getter) Allows retrieval of a single Quote struct by its index in the array.

clearAllQuotes()

public onlyOwner

Administrative function that deletes the entire quote array, effectively resetting the contract's data. Only the contract owner can execute this.

getOwner()

public view

Returns the address of the contract owner.



Events are crucial for DApp frontends to track changes efficiently.

QuoteAdded(address indexed submitter, uint256 index, string quoteText): Emitted after a new quote has been successfully pushed to the array.
