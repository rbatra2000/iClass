//
//  ViewController.swift
//  iClass
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
        self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle.radial, withFrame:view.frame, andColors:[UIColor.flatPowderBlue() as Any, UIColor.flatMint() as Any])
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }

    
    @IBAction func login(_ sender: UIButton) {
        email.text! = email.text!.lowercased()
        course.text! = course.text!.uppercased()
        Auth.auth().signIn(withEmail: email.text!, password: password.text!, completion: { (user, error) in
            if user != nil {
                let docRef = db.collection("Users").document(self.email.text!)
                
                docRef.getDocument { (document, error) in
                    if let document = document {
                        if document.exists {
                            var arrCourses : [String] = []
                            var arrTeaching : [String] = []
                            if (document.get("courses") != nil) {
                                arrCourses = document.get("courses") as! [String]
                            }
                            if (document.get("teaching") != nil) {
                                arrTeaching = document.get("teaching") as! [String]
                            }
                            if (arrCourses.contains(self.course.text!) ) {
                                self.performSegue(withIdentifier: "loginSegue", sender: sender)
                            } else if (arrTeaching.contains(self.course.text!) ) {
                                self.performSegue(withIdentifier: "professorSegue", sender: sender)
                            } else {
                                let alert = UIAlertController(title: "Oops!", message: "You have not signed up for that course!", preferredStyle: .alert)
                            
                                alert.addAction(UIAlertAction(title: "Okay!", style: .default, handler: nil))
                                self.present(alert, animated: true)
                                try! Auth.auth().signOut()
                            }
                        }
                    }
                }
            } else {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (sender as? UIButton) != nil {
            if let dest = segue.destination as? LoggedInViewController {
                dest.course = course.text!
            }
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
    
}
