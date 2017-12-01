//
//  ViewController.swift
//  NestEgg
//
//  Created by Andrew Chau on 11/26/17.
//  Copyright © 2017 Andrew Chau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let myPet = Pet()
    
    var numFood : Int = 0
    var numToys : Int = 0
    var moneySaved : Float = 0.00
    
    
    @IBOutlet weak var HappinessLabel: UILabel!
    @IBOutlet weak var FullnessLabel: UILabel!
    @IBOutlet weak var MoneyLabel: UILabel!
    @IBOutlet weak var FoodLabel: UILabel!
    @IBOutlet weak var ToyLabel: UILabel!
    
    @IBAction func BuyToy(_ sender: UIButton) {
        numToys += 1
        moneySaved += 1.99
        
        updateDisplay()
    }
    @IBAction func BuyFood(_ sender: UIButton) {
        numFood += 1
        moneySaved += 0.99
        
        updateDisplay()
    }
    @IBAction func PlayButton(_ sender: UIButton) {
        if numToys > 0 {
            numToys -= 1
            myPet.playing(happyVal: 15)
            
            updateDisplay()
        }
    }
    @IBAction func FeedButton(_ sender: UIButton) {
        if numFood > 0 {
            numFood -= 1
            myPet.feeding(foodVal: 10)
            myPet.playing(happyVal: 5)
            
            updateDisplay()
        }
    }
    
    func updateDisplay() {
        HappinessLabel.text = "Happiness: \(myPet.happiness)"
        FullnessLabel.text = "Fullness: \(myPet.fullness)"
        
        let moneyFormatted = String(format: "%.2f", moneySaved)
        MoneyLabel.text = "Money Saved: $\(moneyFormatted)"
        
        FoodLabel.text = "Num Food: \(numFood)"
        ToyLabel.text = "Num Toys: \(numToys)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

