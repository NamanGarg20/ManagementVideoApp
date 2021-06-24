//
//  LoginViewController.swift
//  GapAPPNew
//
//  Created by NAMAN GARG on 6/21/21.
//

import UIKit

class LoginViewController: UIViewController {
    var user = ""
    var completion:Completion?
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    func showAlert(_ str: String){
        let alert = UIAlertController(title: "User", message: str, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: {action -> Void in
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    

    @IBAction func login(_ sender: UIButton) {
        
        let userLogin = UserLogin()
        let name = username.text!
        let pass = password.text!
        
        if name.count<1 || pass.count<1{
            showAlert("Username or Password Empty")
            
        }else{
        
        user = name
        userLogin.userLogin(name, pass, false){ [weak self] (result) in
            self?.completion = result
            DispatchQueue.main.async {
                self?.loginUser()
                }
            }
        }
        
    }
        
        func loginUser(){
            if let comp = completion?.result{
                if comp == "Login successful"{
                    let scene = self.view.window?.windowScene?.delegate as? SceneDelegate
                    scene?.showSplitViewController(user)
                }else{
                let alert = UIAlertController(title: "User", message: "\(comp)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ok", style: .default, handler: {action -> Void in
                })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
