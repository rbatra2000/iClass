//
//  TeacherQuestionViewController.swift
//  iClass
//
//  Created by Nicholas Wang on 5/2/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase

class TeacherQuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var questionText: String?
    var allQuestions: [String] = []

    @IBOutlet weak var questionsTable: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        allQuestions = []
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
    }
    
    @IBAction func close(_ sender: Any) {
        performSegue(withIdentifier: "back", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle.radial, withFrame:view.frame, andColors:[UIColor.flatPowderBlue() as Any, UIColor.flatMint() as Any])

        questionsTable.delegate = self
        questionsTable.dataSource = self
        
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
        /*let popUp = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeacherLiteralID") as! TeacherLiteralQuestionViewController
        popUp.questionString = allQuestions[indexPath.row]
        self.addChild(popUp)
        popUp.view.frame = self.view.frame
        self.view.addSubview(popUp.view)
        popUp.didMove(toParent: self)*/
        
        performSegue(withIdentifier: "showTeacherQuestion", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showTeacherQuestion") {
            let dest = segue.destination as! TeacherLiteralQuestionViewController
            let row = (sender as! NSIndexPath).row; //we know that sender is an NSIndexPath here.
            let patientQuestionnaire = allQuestions[row]
            dest.questionString = patientQuestionnaire
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
    
}
