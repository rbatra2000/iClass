//
//  ProfessorViewController.swift
//  iClass
//
//  Created by Ritik Batra on 4/26/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase
import CircleMenu

class ProfessorViewController: UIViewController, CircleMenuDelegate {
    
    var tracking : Bool = false
    let colors = [UIColor.red, UIColor.gray, UIColor.green, UIColor.purple]
    @IBOutlet weak var welcome: UILabel!
    
    
    let items: [(icon: String, color: UIColor)] = [
        ("logout", UIColor(red: 0.19, green: 0.57, blue: 1, alpha: 1)),
        ("toggle", UIColor(red: 0.22, green: 0.74, blue: 0, alpha: 1)),
        ("question", UIColor(red: 0.96, green: 0.23, blue: 0.21, alpha: 1)),
        ("add", UIColor(red: 0.51, green: 0.15, blue: 1, alpha: 1)),
        ("check", UIColor(red: 1, green: 0.39, blue: 0, alpha: 1))
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle.radial, withFrame:view.frame, andColors:[UIColor.flatPowderBlue() as Any, UIColor.flatMint() as Any])
        let docRef = db.collection("Users").document(Auth.auth().currentUser!.email!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.welcome.text = "Welcome, \nProfessor \(document.get("name")!)"
            }
        }
        
        // add button
        let button = CircleMenu(
            frame: CGRect(x: UIScreen.main.bounds.width/2-40, y: UIScreen.main.bounds.height/2-40, width: 80, height: 80),
            normalIcon:"icon_menu",
            selectedIcon:"icon_close",
            buttonsCount: 5,
            duration: 0.5,
            distance: 150)
        button.backgroundColor = UIColor.lightGray
        button.delegate = self
        button.layer.cornerRadius = button.frame.size.width / 2.0
        view.addSubview(button)
    }
    
    // MARK: <CircleMenuDelegate>
    
    func circleMenu(_: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color
        
        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
        
        // set highlited image
        let highlightedImage = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(highlightedImage, for: .highlighted)
        button.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func wait(num: Double) {
        usleep(useconds_t(num*1000000))
    }
    
    func logout() {
        try! Auth.auth().signOut()
        self.performSegue(withIdentifier: "logout", sender: self)
    }
    
    func questions() {
        self.performSegue(withIdentifier: "questions", sender: self)
    }
    
    func toggle() {
        tracking = !tracking
        if (tracking) {
            let alert = UIAlertController(title: "Attendance is turned on!", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Attendance is turned off!", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    func add() {
        
    }
    
    func check() {
        
    }
    
    
    func circleMenu(_: CircleMenu, buttonDidSelected _: UIButton, atIndex: Int) {
        wait(num: 0.5)
        switch atIndex {
        case 0:
            logout()
        case 1:
            toggle()
        case 2:
            questions()
        case 3:
            add()
        case 4:
            check()
        default:
            print("Code Break")
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
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
