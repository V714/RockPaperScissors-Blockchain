var RPS = artifacts.require("RPS");

contract('RPS', function(accounts){

    it("ROCK test choiceToMove function.",function(){
        return RPS.deployed().then(async function(instance){
            let moves = await instance.getMoves()
            let values = {
             value: await instance.testChoiceToMove(0),
             moves: moves['0']
            }
            return values;})
            .then((res) => {assert.equal(res.value,res.moves,"it wasn't rock!")})
  
    })

    it("PAPER test choiceToMove function.",function(){
        return RPS.deployed().then(async function(instance){   
            let moves = await instance.getMoves()
            let values = {
             value: await instance.testChoiceToMove(1),
             moves: moves['1']
            }
            return values;})
            .then((res) => {assert.equal(res.value,res.moves,"it wasn't paper!")})
  
    })

    it("SCISSORS test choiceToMove function.",function(){
        return RPS.deployed().then(async function(instance){  
            let moves = await instance.getMoves()
            let values = {
             value: await instance.testChoiceToMove(2),
             moves: moves['2']
            }
            return values;})
            .then((res) => {assert.equal(res.value,res.moves,"it wasn't scissor!")})
  
    })
})