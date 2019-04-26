//
//  SignUpViewController.swift
//  iClass
//
//  Created by Ritik Batra on 4/6/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import UIKit
import ChameleonFramework
import FirebaseAuth
import Firebase


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
        if (id.text != "" && name.text!.isName && phone.text!.isPhoneNumber) {
                Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion: { (user, error) in
                if user != nil {
                    let person = User(name: self.name.text!, id: self.email.text!, course: (self.id.text)!)
                    addUser(user: person)
                    let course = Course(id: self.id.text!, student: self.email.text!)
                    
                    let docRef = db.collection("Courses").document(course.id)
                    
                    docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            addCourse(course: course)
                            try! Auth.auth().signOut()
                            self.dismiss(animated: true, completion: nil)
                            
                        } else {
                            let alert = UIAlertController(title: "Add New Class", message: nil, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                                let user = Auth.auth().currentUser
                                user!.delete { error in
                                    if let error = error {
                                        // An error happened.
                                        print(error)
                                    } else {
                                        // Account deleted.
                                        db.collection("Users").document(self.email.text!).delete() { err in
                                            if let err = err {
                                                print("Error removing document: \(err)")
                                            } else {
                                                print("Document successfully removed!")
                                            }
                                        }
                                    }
                                }
                            }))
                            alert.addTextField(configurationHandler: { textField in
                                textField.placeholder = "Enter professor name here"
                            })
                            
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                if let name = alert.textFields?.first?.text {
                                    addNewCourse(course: course, name: name)
                                    try! Auth.auth().signOut()
                                    self.dismiss(animated: true, completion: nil)
                                }
                            }))
                            
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                else {
                    if let error = error?.localizedDescription {
                        let alert = UIAlertController(title: "Oops! Something went wrong!", message: error, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Okay!", style: .default, handler: nil))
                        
                        self.present(alert, animated: true)
                    }
                }
            })
        } else {
            let alert = UIAlertController(title: "Please input all the fields correctly.", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay!", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
    
}

extension String {
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    var isName: Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil) && (self.count > 3)
    }
}

