//
//  addCourseViewController.swift
//  iClass
//
//  Created by Ritik Batra on 5/4/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase

class AddClassViewController: UIViewController {
    
    @IBOutlet weak var id: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @IBAction func add(_ sender: Any) {
        let course = Course(id: self.id.text!, student: "")
        let email : String = Auth.auth().currentUser!.email!
        
        let docRef = db.collection("Courses").document(course.id)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                let alert = UIAlertController(title: "Please confirm this is your class!", message: "Enter the password", preferredStyle: .alert)
                
                alert.addTextField(configurationHandler: { textField in
                    textField.placeholder = "Password"
                })
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                }))
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    if let password = alert.textFields?.first?.text {
                        if String(describing: document.get("password")!) != password {
                            // Password Wrong
                        } else {
                            // Password Correct
                            
                            db.collection("Users").document(email).updateData([
                                "teaching": FieldValue.arrayUnion([course.id]),
                                ])
                            changeProf(course: course, email: email)
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
            let alert = UIAlertController(title: "New Class", message: "Please create a password to protect the class.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            }))
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Password"
            })
            
            //New Course
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                if let pass = alert.textFields?.first?.text {
                    addNewCourseProf(course: course, email: email, password: pass)
                    self.dismiss(animated: true, completion: nil)
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
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
