//
//  MyProjectsTableViewCell.swift
//  TaskM_Codebase
//
//  Created by manasa on 7/23/21.
//  Copyright © 2021 manasa. All rights reserved.
//

import UIKit

class MyProjectsTableViewCell: UITableViewCell {

    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectDescriptionLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var cellUIView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellUIView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
