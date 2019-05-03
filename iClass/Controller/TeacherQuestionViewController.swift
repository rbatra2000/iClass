//
//  TeacherQuestionViewController.swift
//  iClass
//
//  Created by Nicholas Wang on 5/2/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import UIKit
import Firebase

class TeacherQuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var questionText: String?
    var allQuestions: [String] = []

    @IBOutlet weak var questionsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let db = Firestore.firestore()
        
        db.collection("Question").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.allQuestions.append(document.documentID)
                }
            }
            self.questionsTable.reloadData()
        }
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        questionsTable.delegate = self
        questionsTable.dataSource = self
        
        self.showAnimate()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "teacherQuestionsCell") as? QuestionsTableViewCell {
            cell.questionLable.text = allQuestions[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopUp(_ sender: AnyObject) {
        self.removeAnimate()
        //self.view.removeFromSuperview()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
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
