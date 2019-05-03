//
//  TeacherLiteralQuestionViewController.swift
//  iClass
//
//  Created by Nicholas Wang on 5/2/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase

class TeacherLiteralQuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    var questionString: String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.numberOfLines = 0
        
        self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle.radial, withFrame:view.frame, andColors:[UIColor.flatPowderBlue() as Any, UIColor.flatMint() as Any])
        
        questionLabel.text = questionString
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func resolveButton(_ sender: Any) {
        db.collection("Question").document(questionString).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    

}
