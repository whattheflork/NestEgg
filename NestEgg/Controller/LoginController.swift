import UIKit
import FBSDKLoginKit
import GoogleSignIn
import Alamofire
import SwiftyJSON

var loggedIn: Bool = false

class LoginController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate {
    
    let login_url = "http://nyu-ios-restapi.us-east-2.elasticbeanstalk.com/login/"
    let checkSession_url = ""
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var login_session:String = ""
    
    func updateDisplay() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redirectIfLoggedIn()
        
        //Google Login Button
        GIDSignIn.sharedInstance().uiDelegate = self
        let googleLoginButton = GIDSignInButton()
        view.addSubview(googleLoginButton)
        googleLoginButton.frame = CGRect(x:16, y: 650, width: view.frame.width - 32, height:50)
        
        //Facebook Login Button
        let fbLoginButton = FBSDKLoginButton()
        view.addSubview(fbLoginButton)
        fbLoginButton.frame = CGRect(x:16, y:550, width: view.frame.width - 32, height:50)
        fbLoginButton.delegate = self
        
//        //Test Credentials
//        usernameField.text = "test1"
//        passwordField.text = "test1"


        let preferences = UserDefaults.standard
        if preferences.object(forKey: "session") != nil
        {
            LoginDone()
        }
        else
        {
            LoginToDo()
        }

        updateDisplay()
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        if(loginButton.titleLabel?.text == "Logout") {
            let preferences = UserDefaults.standard
            preferences.removeObject(forKey: "session")
            LoginToDo()
            return
        }
        
        let username = usernameField.text
        let password = passwordField.text
        
        if username == "" || password == "" {
            return
        }
        
        DoLogin(username!, password!)
    }
    
    func DoLogin(_ user: String, _ password: String) {
        print("got to login")
        let url_request = "\(login_url)username=\(user)&password=\(password)"
        print(url_request)
        Alamofire.request(url_request).responseJSON { response in
            print(response.result.value)
            if let result = response.result.value {
                let json = JSON(result)
//                print(json["url"])
//                print(json["explanation"])
                print(json["success"])
                if(json["success"] == true) {
                    print(user)
                    print(password)
                    self.LoginDone()
                }
            }
        }
    }
    
    
    func LoginDone()
    {
        usernameField.isEnabled = false
        passwordField.isEnabled = false
        
        loginButton.isEnabled = true
        
        print("Login done")
        loggedIn = true
        
        loginButton.setTitle("Logout", for: .normal)
        redirectIfLoggedIn()
    }
    
    func LoginToDo() {
        usernameField.isEnabled = true
        passwordField.isEnabled = true
        
        loginButton.isEnabled = true
        
        loginButton.setTitle("Login", for: .normal)
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
        redirectIfLoggedIn()
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        redirectIfLoggedIn()
        print("Successfully logged in with Facebook...")
    }
    
    func isLoggedIn() -> Bool{
        if FBSDKAccessToken.current() != nil || loggedIn {
            return true
        }
        
        return false
    }
    
    func redirectIfLoggedIn() {
        if self.isLoggedIn() {
            performSegue(withIdentifier: "facebookLoginSwitch", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

