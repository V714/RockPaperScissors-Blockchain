// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

// Rock Paper Scissors - for now it's game with a bot, but shortly will be updated and imported into 2 players webapp game.

contract RPS{
    // hashed so the move is not so easy visible
    bytes32 ROCK;
    bytes32 PAPER;
    bytes32 SCISSORS;
    uint counter;

    constructor(){
        ROCK = keccak256(abi.encodePacked("ROCK"));
        PAPER = keccak256(abi.encodePacked("PAPER"));
        SCISSORS = keccak256(abi.encodePacked("SCISSORS"));
        counter = 0;
    }

    event Game(bool didYouWin);

    modifier tick {
        counter++;
        _;
    }
    
    function choiceToMove(uint8 _choice) private view returns (bytes32) {
        if(_choice == 0) { return ROCK; }
        else if(_choice == 1) { return PAPER; }
        return SCISSORS;
    }

    function justTest() public pure returns(uint256) {
        return 714;
    }

    // play function which returns if you win or not
    function play(uint8 _choice) public tick returns(bool) {
        bytes32 enemyMove = choiceToMove(uint8(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty,counter)))%3));
        bytes32 playerMove = choiceToMove(_choice % 3);
        if(playerMove == ROCK && enemyMove == PAPER){return false;}
        else if(playerMove == ROCK && enemyMove == SCISSORS){return true;}
        else if(playerMove == PAPER && enemyMove == ROCK){return true;}
        else if(playerMove == PAPER && enemyMove == SCISSORS){return false;}
        else if(playerMove == SCISSORS && enemyMove == ROCK){return false;}
        else if(playerMove == SCISSORS && enemyMove == PAPER){return true;}
        else {return false;} // in case players made the same move 
    }
}
