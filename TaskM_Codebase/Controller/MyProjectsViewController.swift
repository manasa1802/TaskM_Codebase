//
//  MyProjectsViewController.swift
//  TaskM_Codebase
//
//  Created by manasa on 6/29/21.
//  Copyright © 2021 manasa. All rights reserved.
//

import UIKit

class MyProjectsViewController: UIViewController {
    @IBOutlet weak var myProjectsView: UIView!
    @IBOutlet weak var myProjectsTableView: UITableView!
    @IBOutlet weak var addProjectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myProjectsView.layer.cornerRadius = 15
        myProjectsTableView.layer.cornerRadius = 15
        addProjectButton.layer.cornerRadius = 25

    }

}
