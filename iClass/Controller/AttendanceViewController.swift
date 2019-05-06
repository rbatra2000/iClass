//
//  AttendanceViewController.swift
//  iClass
//
//  Created by Ritik Batra on 5/5/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import UIKit
import Firebase

class AttendanceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
    var students: [String] = []
    var course: String = ""
    @IBOutlet weak var table: UITableView!
    
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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        table.delegate = self
        table.dataSource = self
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("Courses").document(course)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.students = (document["students"] as? [String] ?? nil)!
            } else {
                print("Document does not exist")
            }
            self.table.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func back(_ sender: Any) {
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
