//
//  MyTasksTableViewCell.swift
//  TaskM_Codebase
//
//  Created by manasa on 7/29/21.
//  Copyright © 2021 manasa. All rights reserved.
//

import UIKit
import Firebase

class MyTasksTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var taskCellView: UIView!
    @IBOutlet weak var taskCellName: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var taskIdLabel: UILabel!
    
    var db = Firestore.firestore()
    var currentTaskDocId = ""
    var currentProjectDocId = ""
    
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
        if sender.titleLabel?.text == "Pending"{
            statusButton.setTitle("In Progress", for: .normal)
            updateStatus(updateTo:"In Progress")
        }else if sender.titleLabel?.text == "In Progress"{
            statusButton.setTitle("Complete", for: .normal)
            updateStatus(updateTo: "Complete")
        }
    }
    
    func updateStatus(updateTo: String) {
        db.collection(Constants.ProjectList.collectionName).document(currentProjectDocId).collection(Constants.TaskList.collectionName).document(currentTaskDocId).updateData([Constants.TaskList.status: updateTo]) { (error) in
            if let err = error{
                print(err)
            }else{
                print(updateTo)
                print("data update success")
            }
        }
    }
    
}

