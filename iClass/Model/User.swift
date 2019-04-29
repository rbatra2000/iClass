//
//  User.swift
//  iClass
//
//  Created by Ritik Batra on 4/18/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import UIKit

class User {
    let name: String
    let id: String
    var courses = [String]()
    var teaching = [String]()
    
    init(name: String, id: String, course: String, teaching: String) {
        self.name = name
        self.id = id
        self.courses.append(course)
        self.teaching.append(teaching)
    }
}
