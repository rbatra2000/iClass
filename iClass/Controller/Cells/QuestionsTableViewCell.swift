//
//  QuestionsTableViewCell.swift
//  QuestionsView
//
//  Created by Nicholas Wang on 4/14/19.
//  Copyright © 2019 Nicholas Wang. All rights reserved.
//

import UIKit

class QuestionsTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
