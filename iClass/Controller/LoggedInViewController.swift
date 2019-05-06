//
//  LoggedInViewController.swift
//  iClass
//
//  Created by Ritik Batra on 4/6/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import UIKit
import ChameleonFramework
import FirebaseAuth
import Firebase

class LoggedInViewController: UIViewController {
    
    var email: String = ""
    var course: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle.radial, withFrame:view.frame, andColors:[UIColor.flatPowderBlue() as Any, UIColor.flatMint() as Any])
        
        email = email.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func attendanceButton(_ sender: Any) {
        
        let docRef = db.collection("Courses").document(course)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        //docRef.updateData(["attendance": [email: FieldValue.arrayUnion([formatter.string(from: date)])]])
        docRef.setData(["attendance": [email: FieldValue.arrayUnion([formatter.string(from: date)])]], merge: true)
    }
    
    @IBAction func logOut(_ sender: Any) {
        try! Auth.auth().signOut()
        self.performSegue(withIdentifier: "logout", sender: self)
    }
    
    @IBAction func addClass(_ sender: Any) {
        let alert = UIAlertController(title: "Enter Class ID:", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input Class ID here..."
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            let email = Auth.auth().currentUser!.email!
            let c = Course(id: (alert.textFields?.first!.text)!.uppercased(), student: email)
            
            db.collection("Users").document(email).updateData([
                "courses": FieldValue.arrayUnion([c.id]),
                ])
            
            let docRef = db.collection("Courses").document(c.id)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    addCourse(course: c)
                } else {
                    let alert = UIAlertController(title: "Please check the course ID", message: "Make sure your professor has already created an account!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }))
        
        self.present(alert, animated: true)
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
