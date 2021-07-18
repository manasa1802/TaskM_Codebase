//
//  CreateNewProjectViewController.swift
//  TaskM_Codebase
//
//  Created by manasa on 7/9/21.
//  Copyright © 2021 manasa. All rights reserved.
//

import UIKit

class CreateNewProjectViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var createProjectView: UIView!
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var projectDescriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createProjectView.layer.cornerRadius = 20
        createButton.layer.cornerRadius = 15
        
//        text field delegate is set to self
        projectNameTextField.delegate = self 
        projectDescriptionTextField.delegate = self
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(false)
        return true
    }
    
    @IBAction func createProjectButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
