import UIKit
import FBSDKLoginKit
import GoogleSignIn

var loggedIn: Bool = false

class LoginController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate {
    
    func updateDisplay() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redirectIfLoggedIn()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        let googleLoginButton = GIDSignInButton()
        view.addSubview(googleLoginButton)
        googleLoginButton.frame = CGRect(x:16, y: 650, width: view.frame.width - 32, height:50)
        
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        
        loginButton.frame = CGRect(x:16, y:550, width: view.frame.width - 32, height:50)
        
        loginButton.delegate = self
        
        updateDisplay()
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

