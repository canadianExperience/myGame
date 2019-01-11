//
//  ViewController.swift
//  SlotMachine_Elena_Melnikova
//
//  Created by Elena Melnikova on 2019-01-11.
//  Copyright © 2019 Centennial College. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblJackpot: UILabel!
    
    @IBOutlet weak var lblCredits: UILabel!
    
    
    @IBOutlet weak var lblTurn: UILabel!
    
    @IBOutlet weak var lblWins: UILabel!
    
    
    @IBOutlet weak var lblLosses: UILabel!
    
    
    @IBOutlet weak var lblBet: UILabel!
    
    
    @IBOutlet weak var lblRatio: UILabel!
    
    
    @IBOutlet weak var lblResult: UILabel!
    
    @IBOutlet weak var lblFruits: UILabel!
    
    var playerMoney = 1000
    var winnings = 0
    var jackpot = 5000
    var turn = 0
    var playerBet = 0
    var winNumber = 0
    var lossNumber = 0
    var spinResult = ["", "", ""]
    var fruits = ""
    var winRatio = 0
    var grapes = 0
    var bananas = 0
    var oranges = 0
    var cherries = 0
    var bars = 0
    var bells = 0
    var sevens = 0
    var blanks = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        showPlayerStats()
        
        
    }
    
    /* Utility function to show Player Stats */
    func showPlayerStats()
    {
        
//        $("#jackpot").text("Jackpot: " + jackpot);
//        $("#playerMoney").text("Player Money: " + playerMoney);
//        $("#playerTurn").text("Turn: " + turn);
//        $("#playerWins").text("Wins: " + winNumber);
//        $("#playerLosses").text("Losses: " + lossNumber);
//        $("#playerWinRatio").text("Win Ratio: " + (winRatio * 100).toFixed(2) + "%");
        
        lblJackpot.text = "Jackpot: \(jackpot)"
        lblCredits.text = "Player Money: \(playerMoney)"
        lblTurn.text = "Turn: \(turn)"
        lblWins.text = "Wins: \(winNumber)"
        lblLosses.text = "Losses: \(lossNumber)"
        var winRatioRounded = "n/a"
        if turn > 0 {
            winRatio = winNumber / turn;
            winRatioRounded = String(Double(String(format: "%.2f", winRatio * 100))!) + "%"
        }
        
        lblRatio.text = "Win Ratio: \(winRatioRounded)"
    }
    
    /* Utility function to reset all fruit tallies */
    func resetFruitTally() {
        grapes = 0
        bananas = 0
        oranges = 0
        cherries = 0
        bars = 0
        bells = 0
        sevens = 0
        blanks = 0
    }
    
    /* Utility function to reset the player stats */
    func resetAll() {
        playerMoney = 1000
        winnings = 0
        jackpot = 5000
        turn = 0
        playerBet = 0
        winNumber = 0
        lossNumber = 0
        winRatio = 0
    }
    
    /* Check to see if the player won the jackpot */
    func checkJackPot() {
        /* compare two random values */
        // var jackPotTry = Math.floor(Math.random() * 51 + 1);
        var jackPotTry = Int(arc4random_uniform(UInt32(51))) + 1
        //var jackPotWin = Math.floor(Math.random() * 51 + 1);
        var jackPotWin = Int(arc4random_uniform(UInt32(51))) + 1
        
        //    if (jackPotTry == jackPotWin) {
        //    alert("You Won the $" + jackpot + " Jackpot!!");
        //    playerMoney += jackpot;
        //    jackpot = 1000;
        //    }
        
        
        if jackPotTry == jackPotWin {
            
            let message = "You Won the $ \(jackpot) Jackpot!!"
            
            alert1("JACKPOT", message)
            
            // create the alert
            //            let alert = UIAlertController(title: "JACKPOT ", message: message, preferredStyle: .alert)
            //
            //            // add an action (button)
            //            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            //
            //            // show the alert
            //            self.present(alert, animated: true, completion: nil)
            
            playerMoney += jackpot
            jackpot = 1000
        }
        
    }
    
    func alert1(_ title: String, _ message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func alert2(_ title: String, _ message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: { action in
            self.alertHandler()
        }))
        
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertHandler(){
        resetAll();
        showPlayerStats();
    }
    
    
    /* Utility function to show a win message and increase player money */
    func showWinMessage() {
        playerMoney += winnings;
        
        lblResult.text = "You Won: $ \(winnings)"
        
        resetFruitTally();
        checkJackPot();
    }
    
    /* Utility function to show a loss message and reduce player money */
    func showLossMessage() {
        playerMoney -= playerBet;
        lblResult.text = "You Lost!"
        resetFruitTally();
    }
    
    /* Utility function to check if a value falls within a range of bounds */
    func checkRange(_ value: Int,_ lowerBounds: Int,_ upperBounds: Int) -> Int {
        
        if (value >= lowerBounds && value <= upperBounds)
        {
            return value
        }
        else {
            return -value
        }
    }
    
    /* When this function is called it determines the betLine results.
     e.g. Bar - Orange - Banana */
    func Reels() -> [String]{
        var betLine = [" ", " ", " "];
        var outCome = [0, 0, 0];
        //
        //        for column in 0..<8 {
        //            sum += row * column
        //        }
        
        for spin in 0..<3{
            
            // for (var spin = 0; spin < 3; spin++) {
            // outCome[spin] = Math.floor((Math.random() * 65) + 1);
            outCome[spin] = Int(arc4random_uniform(UInt32(65))) + 1
            switch (outCome[spin]) {
            case checkRange(outCome[spin], 1, 27):  // 41.5% probability
                betLine[spin] = "blank"
                blanks += 1
                
            case checkRange(outCome[spin], 28, 37): // 15.4% probability
                betLine[spin] = "Grapes"
                grapes += 1
                
            case checkRange(outCome[spin], 38, 46): // 13.8% probability
                betLine[spin] = "Banana"
                bananas += 1
                
            case checkRange(outCome[spin], 47, 54): // 12.3% probability
                betLine[spin] = "Orange"
                oranges += 1
                
            case checkRange(outCome[spin], 55, 59): //  7.7% probability
                betLine[spin] = "Cherry"
                cherries += 1
                
            case checkRange(outCome[spin], 60, 62): //  4.6% probability
                betLine[spin] = "Bar"
                bars += 1
                
            case checkRange(outCome[spin], 63, 64): //  3.1% probability
                betLine[spin] = "Bell"
                bells += 1
                
            case checkRange(outCome[spin], 65, 65): //  1.5% probability
                betLine[spin] = "Seven"
                sevens += 1
                
            default:
                continue
                
            }
        }
        return betLine
    }
    
    /* This function calculates the player's winnings, if any */
    func determineWinnings()
    {
        if (blanks == 0)
        {
            if (grapes == 3) {
                winnings = playerBet * 10;
            }
            else if(bananas == 3) {
                winnings = playerBet * 20;
            }
            else if (oranges == 3) {
                winnings = playerBet * 30;
            }
            else if (cherries == 3) {
                winnings = playerBet * 40;
            }
            else if (bars == 3) {
                winnings = playerBet * 50;
            }
            else if (bells == 3) {
                winnings = playerBet * 75;
            }
            else if (sevens == 3) {
                winnings = playerBet * 100;
            }
            else if (grapes == 2) {
                winnings = playerBet * 2;
            }
            else if (bananas == 2) {
                winnings = playerBet * 2;
            }
            else if (oranges == 2) {
                winnings = playerBet * 3;
            }
            else if (cherries == 2) {
                winnings = playerBet * 4;
            }
            else if (bars == 2) {
                winnings = playerBet * 5;
            }
            else if (bells == 2) {
                winnings = playerBet * 10;
            }
            else if (sevens == 2) {
                winnings = playerBet * 20;
            }
            else if (sevens == 1) {
                winnings = playerBet * 5;
            }
            else {
                winnings = playerBet * 1;
            }
            winNumber += 1
            showWinMessage();
        }
        else
        {
            lossNumber += 1
            showLossMessage();
        }
        
    }
    
    
    
    
    
    
    
    @IBAction func quitGame(_ sender: UIButton) {
    }
    @IBAction func stepper(_ sender: UIStepper) {
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
    }
    @IBAction func spin(_ sender: UIButton) {
        playerBet = Int(lblBet.text!)!
        
        if (playerMoney == 0)
        {
            //        if (confirm("You ran out of Money! \nDo you want to play again?")) {
            //            resetAll();
            //            showPlayerStats();
            //        }
            
            alert2("YOUR CREDITS", "You ran out of Money! \nDo you want to play again?")
            
            
            
        }
        else if (playerBet > playerMoney) {
            // alert("You don't have enough Money to place that bet.")
            alert1("YOUR CREDITS", "You don't have enough Money to place that bet.")
        }
        else if (playerBet < 0) {
            //alert("All bets must be a positive $ amount.");
            alert1("YOUR CREDITS", "All bets must be a positive $ amount.")
        }
        else if (playerBet <= playerMoney) {
            spinResult = Reels();
            fruits = spinResult[0] + " - " + spinResult[1] + " - " + spinResult[2]
            lblFruits.text = fruits
            determineWinnings();
            turn += 1
            showPlayerStats();
        }
        else {
            // alert("Please enter a valid bet amount")
            alert1("YOUR CREDITS", "Please enter a valid bet amount")
        }
    }
}

