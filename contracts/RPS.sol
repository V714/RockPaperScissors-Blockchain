// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

// Rock Paper Scissors - for now it's game with a bot, but shortly will be updated and imported into 2 players webapp game.

contract RPS{
    // hashed so the move is not so visible
    bytes32 constant ROCK = keccak256(abi.encodePacked("ROCK"));
    bytes32 constant PAPER = keccak256(abi.encodePacked("PAPER"));
    bytes32 constant SCISSORS = keccak256(abi.encodePacked("SCISSORS"));
    uint counter = 0;

    event Game(bool didYouWin);

    modifier tick {
        counter++;
        _;
    }
    // moves are intigers between 0 - 2, but to compare hashed ones we need to convert them
    function choiceToMove(uint8 _choice) private pure returns (bytes32) {
        if(_choice == 0) { return ROCK; }
        else if(_choice == 1) { return PAPER; }
        return SCISSORS;
    }

    /*
    // For test purposes only
    function testChoiceToMove(uint8 _choice) public pure returns (bytes32) { // because original function is private
        return choiceToMove(_choice);
    }
    function getMoves() public pure returns (bytes32,bytes32,bytes32) { // just for test cases
        return (ROCK,PAPER,SCISSORS);
    } 
    */


    // play function which returns if you win or not
    function play(uint8 _choice) public tick {
        bytes32 enemyMove = choiceToMove(uint8(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty,counter)))%3));
        bytes32 playerMove = choiceToMove(_choice);
        bool win;
        if(playerMove == ROCK && enemyMove == PAPER){win = false;}
        else if(playerMove == ROCK && enemyMove == SCISSORS){win = true;}
        else if(playerMove == PAPER && enemyMove == ROCK){win = true;}
        else if(playerMove == PAPER && enemyMove == SCISSORS){win = false;}
        else if(playerMove == SCISSORS && enemyMove == ROCK){win = false;}
        else if(playerMove == SCISSORS && enemyMove == PAPER){win = true;}
        else {win = false;} // in case players made the same move 
        emit Game(win);
    }
}
