//
//  MyTasksViewController.swift
//  TaskM_Codebase
//
//  Created by manasa on 7/29/21.
//  Copyright © 2021 manasa. All rights reserved.
//

import UIKit
import Firebase

class MyTasksViewController: UIViewController {
    @IBOutlet weak var myTasksView: UIView!
    @IBOutlet weak var myTasksTableView: UITableView!
    @IBOutlet weak var addNewTaskButton: UIButton!
    
    @IBOutlet weak var reportsButton: UIButton!
    
    var currentDocumentID = ""
    var db = Firestore.firestore()
    
    var myTaskList: [Task] = []
    var cellsNum = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAllTasks()
        myTasksView.layer.cornerRadius = 15
        myTasksTableView.layer.cornerRadius = 15
        addNewTaskButton.layer.cornerRadius = 25
        
        myTasksTableView.register(UINib(nibName: "MyTasksTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.myTaskCellId)
        myTasksTableView.delegate = self
        myTasksTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        
        let backButton = self.navigationController!.navigationBar
        backButton.setBackgroundImage(UIImage(), for: .default)
        backButton.shadowImage = UIImage()
        backButton.isTranslucent = true
        backButton.tintColor = UIColor.black
        backButton.backItem?.title = "Projects"

    }
    
    func loadAllTasks(){
        db.collection(Constants.ProjectList.collectionName).document(currentDocumentID).collection(Constants.TaskList.collectionName).order(by: Constants.TaskList.taskDate).addSnapshotListener { (querySnapshot, error) in
            self.myTaskList = []
            if let err = error{
                print("error : \(err)")
            }else{
//                retreive data here
                for document in querySnapshot!.documents{
                    let data = document.data()
                    let docID = document.documentID
                    
                    if let tName = data[Constants.TaskList.taskName], let tDescription = data[Constants.TaskList.taskDescription], let tStatus = data[Constants.TaskList.status], let tId = data[Constants.TaskList.taskId]{
                        let newTask = Task(taskId: tId as! String, taskName: tName as! String, taskDescription: tDescription as! String, taskDocumentId: docID, status: tStatus as! String)
                        self.myTaskList.append(newTask)
                        
                        DispatchQueue.main.async {
                            self.myTasksTableView.reloadData()
                        }
                    }
                }
            }
        }
    }

    @IBAction func addNewTaskButtonPressed(_ sender: UIButton) {
        //        load create task vc programatically, so that you can have a hold of the doc id

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: Constants.createTaskID) as! CreateNewTaskViewController
        nextViewController.currentDoc = currentDocumentID
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    @IBAction func reportsButtonPressed(_ sender: UIButton) {
    }
    
}

extension MyTasksViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(myTaskList.count)
        return myTaskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.myTaskCellId, for: indexPath) as! MyTasksTableViewCell
        cell.taskCellName.text = myTaskList[indexPath.row].taskName
        cell.taskIdLabel.text = myTaskList[indexPath.row].taskId
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //        delete cells here
        if (editingStyle == .delete){
            let doc = myTaskList[indexPath.row].taskDocumentId
            db.collection(Constants.ProjectList.collectionName).document(currentDocumentID).collection(Constants.TaskList.collectionName).document(doc).delete { (error) in
                if let err = error{
                    print("Error deleting \(err)")
                }else{
                    print("Data deleted successfully")
                    self.myTasksTableView.reloadData()
                }
            }
        }
    }
}
