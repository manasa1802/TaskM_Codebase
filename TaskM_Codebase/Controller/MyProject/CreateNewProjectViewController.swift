//
//  CreateNewProjectViewController.swift
//  TaskM_Codebase
//
//  Created by manasa on 7/9/21.
//  Copyright © 2021 manasa. All rights reserved.
//

import UIKit
import Firebase

class CreateNewProjectViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var createProjectView: UIView!
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var projectDescriptionTextField: UITextField!
    
    @IBOutlet var fullView: UIView!
    
    var db = Firestore.firestore()
    
    var taskBrain = TaskBrain()
    var projectId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createProjectView.layer.cornerRadius = 10
        createButton.layer.cornerRadius = 5
        
//        text field delegate is set to self
        projectNameTextField.delegate = self 
        projectDescriptionTextField.delegate = self
        
//        background view blur - to do
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(false)
        return true
    }
    
    @IBAction func createProjectButtonPressed(_ sender: UIButton) {
        
        if let projectName = projectNameTextField.text, let projectDescription = projectDescriptionTextField.text, let email = Auth.auth().currentUser?.email{

            let projectId = Singleton.sharedInstance.getProjectId()
            db.collection(Constants.ProjectList.collectionName).addDocument(data: [Constants.ProjectList.projectName: projectName,
                 Constants.ProjectList.projectDescription: projectDescription,
                 Constants.ProjectList.emailId: email,
                 Constants.ProjectList.projectDate: Date().timeIntervalSince1970,
                 Constants.ProjectList.projectId: projectId]) { (error) in
                    if let err = error{
                        print(err)
                    }else{
                        print("Data saved successfully")
                        self.dismiss(animated: true, completion: nil)
                    }
                }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func generateProjectId(previousId: Int) -> String{
        projectId += 1
        return "P\(projectId)"
    }
    
}

