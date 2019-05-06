//
//  AttendanceViewController.swift
//  iClass
//
//  Created by Ritik Batra on 5/5/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class AttendanceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var throwawayDict: [String: [String]] = [:]
    
    var dates: [String] = []
    var course: String = ""
    var studentEmail: String = ""
    
    @IBOutlet weak var datesTable: UITableView!
    
    @IBOutlet weak var studentLabel: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "dateID") as? AttendanceTableViewCell{
            cell.label.text = dates[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentLabel.text = studentEmail
        
        self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle.radial, withFrame:view.frame, andColors:[UIColor.flatPowderBlue() as Any, UIColor.flatMint() as Any])

        datesTable.delegate = self
        datesTable.dataSource = self
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("Courses").document(course)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.throwawayDict = document["attendance"] as! [String: [String]]
                let dict = self.throwawayDict[self.studentEmail] ?? nil
                if (dict == nil) {
                } else {
                    self.dates = dict!
                }
            } else {
                print("Document does not exist")
            }
            self.datesTable.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
