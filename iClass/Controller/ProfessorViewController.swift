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
    
        let colors = [UIColor.red, UIColor.gray, UIColor.green, UIColor.purple]


        let items: [(icon: String, color: UIColor)] = [
            ("icon_home", UIColor(red: 0.19, green: 0.57, blue: 1, alpha: 1)),
            ("icon_search", UIColor(red: 0.22, green: 0.74, blue: 0, alpha: 1)),
            ("notifications-btn", UIColor(red: 0.96, green: 0.23, blue: 0.21, alpha: 1)),
            ("settings-btn", UIColor(red: 0.51, green: 0.15, blue: 1, alpha: 1)),
            ("nearby-btn", UIColor(red: 1, green: 0.39, blue: 0, alpha: 1))
        ]
        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle.radial, withFrame:view.frame, andColors:[UIColor.flatPowderBlue() as Any, UIColor.flatMint() as Any])
            
            // add button
            //        let button = CircleMenu(
            //            frame: CGRect(x: 200, y: 200, width: 50, height: 50),
            //            normalIcon:"icon_menu",
            //            selectedIcon:"icon_close",
            //            buttonsCount: 4,
            //            duration: 4,
            //            distance: 120)
            //        button.backgroundColor = UIColor.lightGrayColor()
            //        button.delegate = self
            //        button.layer.cornerRadius = button.frame.size.width / 2.0
            //        view.addSubview(button)
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
        
        func circleMenu(_: CircleMenu, buttonWillSelected _: UIButton, atIndex: Int) {
            print("button will selected: \(atIndex)")
        }
        
        func circleMenu(_: CircleMenu, buttonDidSelected _: UIButton, atIndex: Int) {
            print("button did selected: \(atIndex)")
        }
        
        
        
        
        
        
        
        
        
    var attendance : Bool = false;
    
    
    @IBAction func toggleAttendance(_ sender: UIButton) {
        attendance = !attendance
        if (attendance) {
            sender.setTitle("Disable Attendance Tracking", for: .normal)
        } else {
            sender.setTitle("Enable Attendance Tracking", for: .normal)
            
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        try! Auth.auth().signOut()
        self.performSegue(withIdentifier: "logout", sender: self)
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
