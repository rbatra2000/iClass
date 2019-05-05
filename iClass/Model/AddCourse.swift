//
//  AddCourse.swift
//  iClass
//
//  Created by Ritik Batra on 4/22/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import Foundation
import UIKit
import Firebase

func addCourse(course: Course) {
    
    let docRef = db.collection("Courses").document(course.id)
    
    docRef.updateData(["students": FieldValue.arrayUnion([course.student])])
}

func addNewCourseProf(course: Course, email: String, password: String) {
    
    let docRef = db.collection("Courses").document(course.id)
    
    docRef.setData([
        "email": email,
        "students": [],
        "password": password
    ], merge: true)
}
func changeProf(course: Course, email: String) {
    let docRef = db.collection("Courses").document(course.id)
    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            let prev = document.get("email") as! String
            
            db.collection("Users").document(prev).updateData([
                "teaching": FieldValue.arrayRemove([course.id]),
            ])
            docRef.setData([
                "email": email,
            ], merge: true)
        }
    }
    
}
