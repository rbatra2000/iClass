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
import MapKit
import CoreLocation

class LoggedInViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    let db = Firestore.firestore()
    var lat:Double = 0
    var long:Double = 0
    var courseX:Double = 0;
    var courseY:Double = 0;
    var result = true
    
    static let geoCoder = CLGeocoder()
    
    var email: String = ""
    var course: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle.radial, withFrame:view.frame, andColors:[UIColor.flatPowderBlue() as Any, UIColor.flatMint() as Any])
        
        email = email.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
        }
        
        let questionTab = self.tabBarController!.viewControllers![1] as! QuestionViewController
        questionTab.course = course
        
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        // most recent location update at the end of the array
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        lat = locValue.latitude
        long = locValue.longitude
        
        // do something
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        
    }
    
    func changeState(state : Bool) {
        result = state
    }
    
    func attendanceButton() {
        
        let docRef = db.collection("Courses").document(course)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document["attendanceOn"] as! Bool
                if (dataDescription) {
                    let date = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MM/dd/yyyy"
                    
                    docRef.setData(["attendance": [self.email: FieldValue.arrayUnion([formatter.string(from: date)])]], merge: true)
                }
            }
        }
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
            
            self.db.collection("Users").document(email).updateData([
                "courses": FieldValue.arrayUnion([c.id]),
                ])
            
            let docRef = self.db.collection("Courses").document(c.id)
            
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
    
    @IBAction func markHere(_ sender: Any) {
        
        let docRef = db.collection("Courses").document(course)
        docRef.getDocument() { (document, error) in
            if let document = document {
                let attendenceUp:Bool = document.get("attendanceOn") as! Bool
                self.courseX = document.get("longitude") as! Double
                print("courseX: \(self.courseX)")
                self.courseY = document.get("latitude") as! Double
                print("courseY: \(self.courseY)")
                print("long: \(self.long)")
                print("lat: \(self.lat)")
                let x = abs(self.courseX - self.long)
                let y = abs(self.courseY - self.lat)
                let distance = (x * x + y * y).squareRoot()
                print("distance: \(distance)")
                if distance <= 0.005 {
                    self.changeState(state: true)
                    print("self.result: \(self.result)")
                } else {
                    
                    self.changeState(state: false)
                    print("self.result: \(self.result)")
                }
                
                if attendenceUp == false {
                    let alert = UIAlertController(title: "Attendance not ready!", message: "The professor has not toggled attendance up at the moment.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else if self.result == false {
                    let alert = UIAlertController(title: "Not in Range!", message: "You are not in range! Get closer to class.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Success!", message: "You have been marked here.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    // Success!!
                    self.attendanceButton()
    

                    
                }
            }
        }
        print("inRange end result: \(result)")
        print("after inRange result: \(result)")
        
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
