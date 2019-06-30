//
//  ViewController.swift
//  NoteList
//
//  Created by Shushan Khachatryan on 6/16/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    
    // MARK: - IBAction
    
    @IBAction func loginButton(_ sender: UIButton) {
        if username.text == "" || password.text == "" {
            let alert = UIAlertController.init(title: "Attantion!", message: "Please, enter your username and/or password", preferredStyle: .alert)
            let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true,completion: nil)
        }
        
    }
    


}

