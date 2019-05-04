//
//  StudentTableViewCell.swift
//  iClass
//
//  Created by Nicholas Wang on 5/4/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var studentName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
