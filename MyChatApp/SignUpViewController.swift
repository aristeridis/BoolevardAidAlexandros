//
//  SignUpViewController.swift
//  MyChatApp
//
//  Created by Alexandros on 22/1/18.
//  Copyright © 2018 Alexandros. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class SignUpViewController: UIViewController {
    
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showingKeyboard), name: NSNotification.Name(rawValue: "UiKeyboardWillShowNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hidingKeyabord), name: NSNotification.Name(rawValue: "UiKeybordWillHideNotification"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func SignUp(_ sender: Any) {
        guard let email = email.text , let password = password.text , let fullname = fullname.text
            else {return}
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
            if let error = error {
                self?.alert(message: error.localizedDescription)
                return
            }
            Database.database().reference().child("Users").child(user!.uid).updateChildValues(["email": email, "name": fullname])
            let changeRequest = user?.createProfileChangeRequest()
            changeRequest?.displayName = fullname
            changeRequest?.commitChanges(completion: nil)
            let table = self?.storyboard?.instantiateViewController(withIdentifier: "table") as! MessagesTableViewController
            self?.navigationController?.show(table, sender: nil)
            print("Success SignUp")
        }
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
        print("deinit SignOut")
    }

}
