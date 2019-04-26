//
//  AddCourse.swift
//  iClassAuth
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

func addNewCourse(course: Course, name: String) {
    
    let docRef = db.collection("Courses").document(course.id)
        
    docRef.setData([
        "instructor": name,
        "students": [course.student]
    ], merge: true) { err in
        if let err = err {
            print("Error writing document: \(err)")
        } else {
            print("Document successfully written!")
        }
    }
}
