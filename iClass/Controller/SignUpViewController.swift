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
    @IBOutlet weak var status: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle.radial, withFrame:view.frame, andColors:[UIColor.flatPowderBlue() as Any, UIColor.flatMint() as Any])
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        status.tintColor = UIColor .flatWhite();
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        if (email.text!.hasSuffix(".edu") && id.text != "" && name.text!.isName && phone.text!.isPhoneNumber) {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion: { (user, error) in
                if user != nil {
                    if self.status.selectedSegmentIndex == 0 {
                        
                        let person = User(name: self.name.text!, id: self.email.text!, course: (self.id.text)!, teaching: "")
                        addUser(user: person)
                        let course = Course(id: self.id.text!, student: self.email.text!)
                        
                        let docRef = db.collection("Courses").document(course.id)
                    
                        docRef.getDocument { (document, error) in
                            if let document = document, document.exists {
                                addCourse(course: course)
                                try! Auth.auth().signOut()
                                self.dismiss(animated: true, completion: nil)

                            }
                            let alert = UIAlertController(title: "Add New Class", message: "Please input the professor's email", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                                let user = Auth.auth().currentUser
                                    user!.delete { error in
                                        if let error = error {
                                            // An error happened.
                                            print(error)
                                        } else {
                                            // Account deleted.
                                            db.collection("Users").document(self.email.text!).delete()
                                        }
                                }
                            }))
                            alert.addTextField(configurationHandler: { textField in
                                textField.placeholder = "Professor Email"
                            })
                            
                        
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                if let email = alert.textFields?.first?.text {
                                    
                                    // Check if professor exists for course defined
                                    // addNewCourse(course: course)
                                    try! Auth.auth().signOut()
                                    self.dismiss(animated: true, completion: nil)
                                }
                            }))
                            
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let person = User(name: self.name.text!, id: self.email.text!, course: "", teaching: (self.id.text)!)
                        addUser(user: person)
                        let course = Course(id: self.id.text!, student: "")
                        
                        let docRef = db.collection("Courses").document(course.id)
                        
                        docRef.getDocument { (document, error) in
                            if let document = document, document.exists {
                                
                                let alert = UIAlertController(title: "Please confirm this is your class!", message: "Enter the password", preferredStyle: .alert)
                                
                                alert.addTextField(configurationHandler: { textField in
                                    textField.placeholder = "Password"
                                })
                                
                                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                                    let user = Auth.auth().currentUser
                                    user!.delete { error in
                                        if let error = error {
                                            print(error)
                                        } else {
                                            // Account deleted.
                                            db.collection("Users").document(self.email.text!).delete()
                                        }
                                    }
                                }))
                                
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                    if let password = alert.textFields?.first?.text {
                                        if String(describing: document.get("password")!) != password {
                                            // Password Wrong
                                            let user = Auth.auth().currentUser
                                            user!.delete { error in
                                                if let error = error {
                                                    print(error)
                                                } else {
                                                    // Account deleted.
                                                    db.collection("Users").document(self.email.text!).delete()
                                                }
                                            }
                                        } else {
                                            // Password Correct
                                            changeProf(course: course, email: self.email.text!)
                                            try! Auth.auth().signOut()
                                            self.dismiss(animated: true, completion: nil)
                                        }
                                    }
                                }))
                                
                                self.present(alert, animated: true, completion: nil)
                            }
                            let alert = UIAlertController(title: "New Class", message: "Please create a password to protect the class.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                                let user = Auth.auth().currentUser
                                user!.delete { error in
                                    if let error = error {
                                        print(error)
                                    } else {
                                        // Account deleted.
                                        db.collection("Users").document(self.email.text!).delete()
                                    }
                                }
                            }))
                            alert.addTextField(configurationHandler: { textField in
                                textField.placeholder = "Password"
                            })
                            
                            //New Course
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                if let pass = alert.textFields?.first?.text {
                                    addNewCourseProf(course: course, email: self.email.text!, password: pass)
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
            let alert = UIAlertController(title: "Oops! Something went wrong!", message: "Please ensure that you inputted your full name, school email, and phone number (no parentheses or dashes).", preferredStyle: .alert)
            
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

