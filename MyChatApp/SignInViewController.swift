//
//  SignInViewController.swift
//  MyChatApp
//
//  Created by Alexandros on 22/1/18.
//  Copyright © 2018 Alexandros. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class SignInViewController: UIViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showingKeyboard), name: NSNotification.Name(rawValue: "UiKeyboardWillShowNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hidingKeyabord), name: NSNotification.Name(rawValue: "UiKeybordWillHideNotification"), object: nil)//hides keyboard οταν πατας σε αλλο σημειο της οθόνης
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func SignIn(_ sender: Any) {
        guard let email = email.text, let password = password.text else {return}
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            if let error = error {
                self?.alert(message: error.localizedDescription)
                return
            }
            let table = self?.storyboard?.instantiateViewController(withIdentifier: "table") as! MessagesTableViewController
            self?.navigationController?.show(table, sender: nil)
            
            print("success SignIn")
        }
        
    }
    
    @IBAction func SignUp(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "SIGNUP") as! SignUpViewController
        self.navigationController?.show(controller, sender: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    deinit {
        print("deinit SignIn")
    }

}
