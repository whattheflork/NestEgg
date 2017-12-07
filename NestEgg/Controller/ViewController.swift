//
//  ViewController.swift
//  NestEgg
//
//  Created by Andrew Chau on 11/26/17.
//  Copyright © 2017 Andrew Chau. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Braintree
import BraintreeDropIn

let clientToken = "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiIwZjgxMDEwNTVjZTI5N2VjNzE3NWE2OWQ2ZGFhYTQ3ZTg2M2RmZGU5ZWY4NDdiMzc0ZjI5ZjFjNTkxMDVhYjM1fGNyZWF0ZWRfYXQ9MjAxNy0xMi0wN1QyMTo0NTo1OC4wNjIzMTQwMzgrMDAwMFx1MDAyNm1lcmNoYW50X2lkPTM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJjaGFsbGVuZ2VzIjpbXSwiZW52aXJvbm1lbnQiOiJzYW5kYm94IiwiY2xpZW50QXBpVXJsIjoiaHR0cHM6Ly9hcGkuc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbTo0NDMvbWVyY2hhbnRzLzM0OHBrOWNnZjNiZ3l3MmIvY2xpZW50X2FwaSIsImFzc2V0c1VybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXV0aFVybCI6Imh0dHBzOi8vYXV0aC52ZW5tby5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tIiwiYW5hbHl0aWNzIjp7InVybCI6Imh0dHBzOi8vY2xpZW50LWFuYWx5dGljcy5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tLzM0OHBrOWNnZjNiZ3l3MmIifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaWRnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllbnQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImFjbWV3aWRnZXRzbHRkc2FuZGJveCIsImN1cnJlbmN5SXNvQ29kZSI6IlVTRCJ9LCJtZXJjaGFudElkIjoiMzQ4cGs5Y2dmM2JneXcyYiIsInZlbm1vIjoib2ZmIn0="

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
        showDropIn()
        numToys += 1
        moneySaved += 1.99
        
        updateDisplay()
    }
    @IBAction func BuyFood(_ sender: UIButton) {
        showDropIn()
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
    
    func showDropIn() {
        let request = BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientToken, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                // Use the BTDropInResult properties to update your UI
                // result.paymentOptionType
                // result.paymentMethod
                // result.paymentIcon
                // result.paymentDescription
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
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

