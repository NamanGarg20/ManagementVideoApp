//
//  AccountViewController.swift
//  GapAPPNew
//
//  Created by NAMAN GARG on 6/21/21.
//

import UIKit

class AccountViewController: UIViewController {
    let userLogin = UserLogin()
    var completion:Completion?
    var user = ""
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var confirm: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func signUPUser(){
        if let comp = completion?.result{

            
            if comp == "success"{
                let alert = UIAlertController(title: "User", message: "\(comp)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: {action -> Void in
                    self.navigationController?.popViewController(animated: true)
                })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "User", message: "\(comp)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: {action -> Void in
                })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        
        let name = username.text!
        let pass = password.text!
        let confirmPass = confirm.text!
        user = name
        if pass != confirmPass {
            showAlert()
        }
        userLogin.userLogin(name, pass, true){ [weak self] result in
            self?.completion = result
            DispatchQueue.main.async {
                self?.signUPUser()
            }
        }
        
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "User", message: "passwords don't match", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: {action -> Void in
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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
