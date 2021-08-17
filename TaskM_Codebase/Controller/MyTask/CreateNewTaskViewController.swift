//
//  CreateNewTaskViewController.swift
//  TaskM_Codebase
//
//  Created by manasa on 8/4/21.
//  Copyright © 2021 manasa. All rights reserved.
//

import UIKit
import Firebase

class CreateNewTaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var taskView: UIView!
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextField: UITextField!
    
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var createTaskButton: UIButton!
    
    var currentDoc = ""
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskView.layer.cornerRadius = 10
        createTaskButton.layer.cornerRadius = 5
        
        taskNameTextField.delegate = self
        taskDescriptionTextField.delegate = self
        statusButton.titleLabel?.text = Constants.Status.pending
//        something about button here
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(false)
        return true
    }
    
    @IBAction func statusButtonPressed(_ sender: UIButton) {
        
        if sender.titleLabel?.text == Constants.Status.pending{
            statusButton.setTitle(Constants.Status.inProgress, for: .normal)
        }else if sender.titleLabel?.text == Constants.Status.inProgress{
            statusButton.setTitle(Constants.Status.complete, for: .normal)
        }else if sender.titleLabel?.text == Constants.Status.complete{
            statusButton.setTitle(Constants.Status.pending, for: .normal)
        }
    }
    
    @IBAction func createTaskButtonPressed(_ sender: UIButton) {
        if let taskName = taskNameTextField.text, let taskDescription = taskDescriptionTextField.text, let status = statusButton.titleLabel?.text{
                
            let taskID = Singleton.sharedInstance.getTaskId()
            db.collection(Constants.ProjectList.collectionName).document(currentDoc).collection(Constants.TaskList.collectionName).addDocument(data: [Constants.TaskList.taskName: taskName,
                                                                                                                Constants.TaskList.taskDescription: taskDescription, Constants.TaskList.status: status, Constants.TaskList.taskDate: Date().timeIntervalSince1970, Constants.TaskList.taskId: taskID]){ (Error) in
                
                if let err = Error{
                    print("error saving data \(err)")
                }else{
                    print("data stored successfully")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
