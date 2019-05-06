//
//  ProfessorStudentTableViewController.swift
//  iClass
//
//  Created by Nicholas Wang on 5/4/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ProfessorStudentTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var students: [String] = []
    var course: String = ""
    
    @IBOutlet weak var totalLabel: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell") as? StudentTableViewCell {
            cell.studentName.text = students[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    @IBOutlet weak var studentTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle.radial, withFrame:view.frame, andColors:[UIColor.flatPowderBlue() as Any, UIColor.flatMint() as Any])
        
        studentTable.delegate = self
        studentTable.dataSource = self
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("Courses").document(course)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.students = (document["students"] as? [String] ?? nil)!
            } else {
                print("Document does not exist")
            }
            self.studentTable.reloadData()
            self.totalLabel.text = "Total: " + String(self.students.count)
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*let popUp = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeacherLiteralID") as! TeacherLiteralQuestionViewController
         popUp.questionString = allQuestions[indexPath.row]
         self.addChild(popUp)
         popUp.view.frame = self.view.frame
         self.view.addSubview(popUp.view)
         popUp.didMove(toParent: self)*/
        
        performSegue(withIdentifier: "attendancePopup", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "attendancePopup") {
            let dest = segue.destination as! AttendanceViewController
            let indexPath = self.studentTable.indexPathForSelectedRow
            let patientQuestionnaire = students[(indexPath?.row)!]
            dest.studentEmail = patientQuestionnaire
            dest.course = course
        }
    }
    

}
