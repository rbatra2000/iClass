//
//  ViewController.swift
//  iClassAuth
//
//  Created by Ritik Batra on 4/6/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import UIKit
import ChameleonFramework
import FirebaseAuth

class InitialViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var course: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle.radial, withFrame:view.frame, andColors:[UIColor.flatSkyBlue() as Any, UIColor.flatGreen() as Any])
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }

    
    @IBAction func login(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!, completion: { (user, error) in
            if user != nil {
                print("Worked")
                self.performSegue(withIdentifier: "loginSegue", sender: sender)
            }
            else {
                if let error = error?.localizedDescription {
                    let alert = UIAlertController(title: "Oops! Something went wrong!", message: error, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Okay!", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                } else {
                    print("ERROR")
                }
            }
        })
    }
    
}
