//
//  SignUpViewController.swift
//  iClassAuth
//
//  Created by Ritik Batra on 4/6/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import UIKit
import ChameleonFramework
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle.radial, withFrame:view.frame, andColors:[UIColor.flatSkyBlue() as Any, UIColor.flatGreen() as Any])
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion: { (user, error) in
                if user != nil {
                    print("Worked")
                    self.dismiss(animated: true, completion: nil)
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
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
