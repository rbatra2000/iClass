//
//  AddUser.swift
//  iClass
//
//  Created by Ritik Batra on 4/18/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import Foundation
import UIKit
import Firebase

let db = Firestore.firestore()

func addUser(user: User) {
    if (user.courses == [""] ) {
        db.collection("Users").document(user.id).setData([
            "name": user.name,
            "teaching": user.teaching
            ], merge: true)
    } else {
        db.collection("Users").document(user.id).setData([
            "name": user.name,
            "courses": user.courses
            ], merge: true)
    }
    
}
