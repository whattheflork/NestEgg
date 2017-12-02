import UIKit
import FBSDKLoginKit

class LoginController: UIViewController {
    
    func updateDisplay() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        
        loginButton.frame = CGRect(x:16, y:50, width: view.frame.width - 32, height:50)
        
        updateDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

