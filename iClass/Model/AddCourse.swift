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

func addNewCourse(course: Course, email: String) {
    
    let docRef = db.collection("Courses").document(course.id)
        
    docRef.setData([
        "email": email,
        "students": [course.student],
    ], merge: true) { err in
        if let err = err {
            print("Error writing document: \(err)")
        } else {
            print("Document successfully written!")
        }
    }
}

func addNewCourseProf(course: Course, email: String, password: String) {
    
    let docRef = db.collection("Courses").document(course.id)
    
    docRef.setData([
        "email": email,
        "students": [course.student],
        "password": password
    ], merge: true) { err in
        if let err = err {
            print("Error writing document: \(err)")
        } else {
            print("Document successfully written!")
        }
    }
}

func changeProf(course: Course, email: String) {
    let docRef = db.collection("Courses").document(course.id)
    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            docRef.setData([
                "email": email,
                ], merge: true)
        } else {
            print("Document does not exist")
        }
    }
    
}
