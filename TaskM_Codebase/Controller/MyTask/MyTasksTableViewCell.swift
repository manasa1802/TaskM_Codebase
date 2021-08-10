//
//  MyTasksTableViewCell.swift
//  TaskM_Codebase
//
//  Created by manasa on 7/29/21.
//  Copyright © 2021 manasa. All rights reserved.
//

import UIKit

class MyTasksTableViewCell: UITableViewCell {

    @IBOutlet weak var taskCellView: UIView!
    @IBOutlet weak var taskCellName: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var taskIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        taskCellView.layer.cornerRadius = 10
        statusButton.layer.cornerRadius = 18
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func statusButtonPressed(_ sender: UIButton) {
        print("button pressed")
        if sender.titleLabel?.text == "Pending"{
            statusButton.setTitle("In progress", for: .normal)
        }else if sender.titleLabel?.text == "In progress"{
            statusButton.setTitle("Complete", for: .normal)
        }else if sender.titleLabel?.text == "Complete"{
            statusButton.setTitle("Pending", for: .normal)
        }
    }
    
}
