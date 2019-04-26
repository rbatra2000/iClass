//
//  User.swift
//  iClassAuth
//
//  Created by Ritik Batra on 4/18/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import UIKit

class User {
    let name: String
    let id: String
    var courses = [String]()

    
    init(name: String, id: String, course: String) {
        self.name = name
        self.id = id
        courses.append(course)
    }
}
