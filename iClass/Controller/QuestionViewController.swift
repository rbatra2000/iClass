//
//  ViewController.swift
//  QuestionsView
//
//  Created by Nicholas Wang on 4/9/19.
//  Copyright © 2019 Nicholas Wang. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var inputQuestion: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle.radial, withFrame:view.frame, andColors:[UIColor.flatSkyBlue() as Any, UIColor.flatGreen() as Any])
        
        inputQuestion.layer.cornerRadius = 6.0
        inputQuestion.layer.masksToBounds = true
        inputQuestion.layer.borderColor = UIColor.lightGray.cgColor
        inputQuestion.layer.borderWidth = 3.0
    }
    
    @IBAction func showQuestionsPopUp(_ sender: Any) {
        
        let popUp = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpID") as! QuestionsPopUpControllerViewController
        self.addChild(popUp)
        popUp.view.frame = self.view.frame
        self.view.addSubview(popUp.view)
        popUp.didMove(toParent: self)
        
    }
    
    @IBAction func submitQuestion(_ sender: Any) {
        
        let db = Firestore.firestore()
        let questionToStore = inputQuestion.text
        
        let notTooLong = inputQuestion.text.count < 450
        
        if questionToStore != "" && notTooLong {
            db.collection("Question").document(questionToStore ?? "").setData([
                "question": questionToStore ?? "None"
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
        else {
            let alert = UIAlertController(title: "Error", message: "You must have between 1 to 450 characters!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
}
