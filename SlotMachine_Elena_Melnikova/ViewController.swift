//
//  ViewController.swift
//  Created by Elena Melnikova on 2019-01-11.
//  Slot Machine
//  iPhone SE and iPhone 5s
//  Student ID: 301025880
//  Description: SlotMachine mobile application imitates a casino game. The application contains BETs and SPIN buttons, RES button sets the game to initial parameters, QUIT button terminates the application, game results are displayed into the CREDIT, BET, WINNIGS and JACKPOT labels, PickerView is used for reel animation.
//  Copyright © 2019 Centennial College. All rights reserved.

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    // Set a number of pickerView components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    // Set initial parameters
    @IBOutlet weak var lblJackpot: UILabel!
    
    @IBOutlet weak var lblCredits: UILabel!
    
    @IBOutlet weak var lblWins: UILabel!
    
    @IBOutlet weak var lblBet: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var btnSpin: UIButton!
    
    var playerMoney = 1000
    var winnings = 0
    var jackpot = 5000
    var playerBet = 0
    var winNumber = 0
    var lossNumber = 0
    var spinResult = ["", "", ""]
    var grapes = 0
    var bananas = 0
    var oranges = 0
    var cherries = 0
    var bars = 0
    var bells = 0
    var sevens = 0
    var blanks = 0
    var fruitArray = [String]()
    var component1 = [Int]()
    var component2 = [Int]()
    var component3 = [Int]()
    var bounds: CGRect = CGRect.zero
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fruitArray = ["blank","grapes","banana","orange","cherry","bar","bell","seven"]
       
        // Start pickerView image initialization
        for i in 0..<8 {
            component1.append(i)
            component2.append(i)
            component3.append(i)
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        showPlayerStats()
    }
    
    // Utility function to show Player Stats
    func showPlayerStats()
    {
        lblBet.text = String(playerBet)
        lblJackpot.text = "\(jackpot)"
        lblCredits.text = "\(playerMoney)"
        lblWins.text = "\(winNumber)"
    }
    
    // Utility function to reset all fruit tallies
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
    
    // Utility function to reset the player stats
    func resetAll() {
        playerMoney = 1000
        winnings = 0
        jackpot = 5000
        playerBet = 0
        winNumber = 0
    }
    
    // Check to see if the player won the jackpot
    func checkJackPot() {
        
        // compare two random values
       
        var jackPotTry = Int(arc4random_uniform(UInt32(51))) + 1
        
        var jackPotWin = Int(arc4random_uniform(UInt32(51))) + 1
    
        if jackPotTry == jackPotWin {
            let message = "You Won the $ \(jackpot) Jackpot!!"
            alert1("JACKPOT", message)
            playerMoney += jackpot
            jackpot = 1000
            play(soundName: "jackPot")
        }
        else {
            play(soundName: "win")
        }
    }
    // Create alert function with "OK" button
    func alert1(_ title: String, _ message: String){
        play(soundName: "alert")
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    // Create alert function with "YES" and "NO" buttons
    func alert2(_ title: String, _ message: String){
        
        play(soundName: "alert")
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: { action in
            self.alertHandler()
        }))
        
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
        // Handler for "YES" button
    func alertHandler(){
        btnSpin.isEnabled = true
        resetAll();
        showPlayerStats();
    }
    
    // Utility function to show a win message and increase player money
    func showWinMessage() {
        playerMoney += winnings;
        resetFruitTally();
        checkJackPot();
    }
    
    // Utility function to show a loss message and reduce player money
    func showLossMessage() {
        playerMoney -= playerBet;
        resetFruitTally();
    }
    
    // Utility function to check if a value falls within a range of bounds
    func checkRange(_ value: Int,_ lowerBounds: Int,_ upperBounds: Int) -> Int {
        
        if (value >= lowerBounds && value <= upperBounds)
        {
            return value
        }
        else {
            return -value
        }
    }
    
//    When this function is called it determines the betLine results.
//     e.g. Bar - Orange - Banana
    func Reels() -> [String]{
        var betLine = [" ", " ", " "];
        var outCome = [0, 0, 0];
        
        for spin in 0..<3{
            outCome[spin] = Int(arc4random_uniform(UInt32(65))) + 1
            switch (outCome[spin]) {
            //Blank
            case checkRange(outCome[spin], 1, 27):  // 41.5% probability
                betLine[spin] = fruitArray[0]
                blanks += 1
             //Grapes
            case checkRange(outCome[spin], 28, 37): // 15.4% probability
                betLine[spin] = fruitArray[1]
                grapes += 1
            //Banana
            case checkRange(outCome[spin], 38, 46): // 13.8% probability
                betLine[spin] = fruitArray[2]
                bananas += 1
            //Orange
            case checkRange(outCome[spin], 47, 54): // 12.3% probability
                betLine[spin] = fruitArray[3]
                oranges += 1
             //Cherry
            case checkRange(outCome[spin], 55, 59): //  7.7% probability
                betLine[spin] = fruitArray[4]
                cherries += 1
             //Bar
            case checkRange(outCome[spin], 60, 62): //  4.6% probability
                betLine[spin] = fruitArray[5]
                bars += 1
            //Bell
            case checkRange(outCome[spin], 63, 64): //  3.1% probability
                betLine[spin] = fruitArray[6]
                bells += 1
            //Seven
            case checkRange(outCome[spin], 65, 65): //  1.5% probability
                betLine[spin] = fruitArray[7]
                sevens += 1
            default:
                continue
            }
        }
        return betLine
    }
    
    // This function calculates the player's winnings, if any
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
            showWinMessage()
        }
        else
        {
            lossNumber += 1
            showLossMessage()
        }
    }
   
    // Set bet1 label
    @IBAction func bet1(_ sender: UIButton) {
        play(soundName: "bet")
        playerBet = 1
        lblBet.text = String(playerBet)
    }
    // Set bet10 label
    @IBAction func bet10(_ sender: UIButton) {
        play(soundName: "bet")
        playerBet = 10
        lblBet.text = String(playerBet)
    }
    // Set bet100 label
    @IBAction func bet100(_ sender: UIButton) {
        play(soundName: "bet")
        playerBet = 100
        lblBet.text = String(playerBet)
    }
    // Set betMax label
    @IBAction func betMax(_ sender: UIButton) {
        play(soundName: "bet")
        playerBet = playerMoney
        lblBet.text = String(playerBet)
    }
    // QUIT button action
    @IBAction func quitGame(_ sender: UIButton) {
        play(soundName: "quit")
    }
    // RES button action, reset game to initial stage
    @IBAction func resetGame(_ sender: UIButton) {
        play(soundName: "res")
        resetAll()
        showPlayerStats()
        btnSpin.isEnabled = true
    }
    // SPIN button action
    @IBAction func spin(_ sender: UIButton) {
        play(soundName: "spin")
        playerBet = Int(lblBet.text!)!
        
        if playerMoney == 0
        {
            alert2("ATTENTION", "You ran out of Money! \nDo you want to play again?")
            btnSpin.isEnabled = false
        }
        else if playerBet > playerMoney {
            alert1("ATTENTION", "You don't have enough Money to place that bet.")
        }
        else if playerBet <= 0 {
            alert1("ATTENTION", "All bets must be a positive $ amount.")
        }
        else if playerBet <= playerMoney {
            spinResult = Reels();
            
            let indexOf0 = fruitArray.firstIndex(of: spinResult[0])!
            let indexOf1 = fruitArray.firstIndex(of: spinResult[1])!
            let indexOf2 = fruitArray.firstIndex(of: spinResult[2])!
            
            pickerView.selectRow(indexOf0, inComponent: 0, animated: true)
            pickerView.selectRow(indexOf1, inComponent: 1, animated: true)
            pickerView.selectRow(indexOf2, inComponent: 2, animated: true)
  
            determineWinnings();
            showPlayerStats();
        }
        else {
            alert1("YOUR CREDITS", "Please enter a valid bet amount")
        }
    }
    
    // UIPickerView DataSource
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        //number of rows
        return 8
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return CGFloat(58.0)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(58.0)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        // Set pickerView size and size of images
        let myView = UIView(frame: CGRect(x:0, y:0, width:pickerView.bounds.width - 140, height:58))
        let myImageView = UIImageView(frame: CGRect(x:0, y:0, width:58, height:58))
        
        // Set images to pickerVew rows
        switch component {
        case 0:
            let fruit = fruitArray[component1[row]]
            myImageView.image = UIImage(named:fruit)
        case 1:
            let fruit = fruitArray[component2[row]]
            myImageView.image = UIImage(named:fruit)
        case 2:
            let fruit = fruitArray[component3[row]]
            myImageView.image = UIImage(named:fruit)
        default:
            let fruit = fruitArray[component1[row]]
            myImageView.image = UIImage(named:fruit)
        }
        myView.addSubview(myImageView)
        return myView
    }
    
    // This function play sounds
    func play(soundName: String) {
        
        // Play system sound with custom mp3 file
        if let customSoundUrl = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            var customSoundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(customSoundUrl as CFURL, &customSoundId)
            
//            AudioServicesAddSystemSoundCompletion(customSoundId, nil, nil, { (customSoundId, _) -> Void in
//                AudioServicesDisposeSystemSoundID(customSoundId)
//            }, nil)
            
            
            if soundName == "quit" {
                AudioServicesAddSystemSoundCompletion(customSoundId, nil, nil, soundFinished, nil)
            }
            AudioServicesPlaySystemSound(customSoundId)
        }
    }
}

//Play sound and then exit from app
func soundFinished(_ snd:UInt32, _ c:UnsafeMutableRawPointer?) {
    print("finished!")
    AudioServicesRemoveSystemSoundCompletion(snd)
    AudioServicesDisposeSystemSoundID(snd)
    exit(0)
}

