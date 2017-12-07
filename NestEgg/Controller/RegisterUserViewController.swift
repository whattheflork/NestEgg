//
//  RegisterUserViewController.swift
//  Hello World
//
//  Created by Calvin Lin on 11/18/17.
//  Copyright © 2017 Calvin Lin. All rights reserved.
//

import UIKit

class RegisterUserViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var comfirmPasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButtonTapped(_ sender: AnyObject) {
        print("Sign in button tapped")
        
        // validate required fields are not empty
        if  (usernameTextField.text?.isEmpty)! ||
            (emailTextField.text?.isEmpty)! ||
            (passwordTextField.text?.isEmpty)!
        {
            // some field is empty
            displayMessage(userMessage: "All fields are required to be filled in")
            return
        }
        
        // validate password
        if passwordTextField.text != comfirmPasswordTextField.text
        {
            // passwords are different
            displayMessage(userMessage: "Please make sure that the passwords match")
            return
        }
        
        // create activity indicator
        let myActivityIndicator =
            UIActivityIndicatorView(activityIndicatorStyle:
            UIActivityIndicatorViewStyle.gray)
        
        // position activity indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // if needed, you can prevent activity indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // start activity indicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
        let myUrl = URL(string: "http://nyu-ios-restapi.us-east-2.elasticbeanstalk.com/create-user/username=\(usernameTextField.text!)&password=\(passwordTextField.text!)&email=\(emailTextField.text!)")!
        var request = URLRequest(url: myUrl)
        print(myUrl)
        request.httpMethod = "POST"
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = ["username": usernameTextField.text!,
                          "password": passwordTextField.text!,
            "email": emailTextField.text!] as [String: String]
        
        print("After postString???")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong. Try again.")
            return
        }
        
        print("After request.httpbody???")
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
            if error != nil {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print("error=\(String(describing: error))")
                return
            }
            print("After error checking???")
            
            do {
                print("before JSONSErialization???")
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
                
                print("after JSONSErialization???")
                print("Success? \(String(describing: json?["success"]))!")
                if let parseJSON = json {
                    let userId = parseJSON["success"] as? String
                    print("User id: \(String(describing: userId))")
                    
                    if(String(describing: json?["success"]) != "Optional(1)") {
                        self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
                        return
                    } else {
                        self.displayMessage(userMessage: "Successfully registered a new account. Please proceed to sign.")
                    }
                } else {
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                }
            } catch {
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
                print(error)
            }
            
        }
        task.resume()
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        print("Cancel button tapped")
    }
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title:"Alert", message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style:. default) {
                (action:UIAlertAction!) in
                print("Ok button tapped")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
            alertController.addAction(OKAction)
            // present alertController message
            self.present(alertController, animated: true, completion:nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
