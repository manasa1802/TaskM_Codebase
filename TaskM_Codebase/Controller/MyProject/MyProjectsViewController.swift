//
//  MyProjectsViewController.swift
//  TaskM_Codebase
//
//  Created by manasa on 6/29/21.
//  Copyright © 2021 manasa. All rights reserved.
//

import UIKit
import Firebase

protocol TrackProgressDelegate {
    func didUpdateProgress(pending: Int, inProgress: Int, complete: Int)
}

class MyProjectsViewController: UIViewController {
    @IBOutlet weak var myProjectsView: UIView!
    @IBOutlet weak var myProjectsTableView: UITableView!
    @IBOutlet weak var addProjectButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    var myProjectList: [Project] = []
    var db = Firestore.firestore()
    
    var delegate: TrackProgressDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myProjectsView.layer.cornerRadius = 15
        myProjectsTableView.layer.cornerRadius = 15
        addProjectButton.layer.cornerRadius = 25
      
//      load existing projects
        loadAllProjects()
        
        myProjectsTableView.register(UINib(nibName: "myProjectsTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.projectCellId)
        myProjectsTableView.delegate = self
        myProjectsTableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
        self.loadAllProjects()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func signOutButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "IsLoggedIn")
        UserDefaults.standard.synchronize()
        
//        do additional signout stuffs for firebase signout
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: Constants.loginScreenId) as! LoginViewController
        
//        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(nextViewController)
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    func loadAllProjects(){
        db.collection(Constants.ProjectList.collectionName).order(by: Constants.ProjectList.projectDate).addSnapshotListener { (querySnapshot, error) in
            self.myProjectList = []
            
            if let err = error{
                print(err)
            }else{
//                retreive the data
                for document in querySnapshot!.documents{
                    let data = document.data()
                    if let user = data[Constants.ProjectList.emailId] as? String {
                        let docID = document.documentID
                        if Auth.auth().currentUser?.email == user{
//                            retive data and append to the variables locally
                            if let pName = data[Constants.ProjectList.projectName], let pDescription = data[Constants.ProjectList.projectDescription], let pId = data[Constants.ProjectList.projectId]{
                                let newProject = Project(projectId: pId as! String, projectName: pName as! String, projectDescription: pDescription as! String, documentId: docID)
                                self.myProjectList.append(newProject)
                                
                                DispatchQueue.main.async {
                                     self.myProjectsTableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension MyProjectsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myProjectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.projectCellId, for: indexPath) as! MyProjectsTableViewCell
        cell.projectNameLabel.text = myProjectList[indexPath.row].projectName
        cell.projectDescriptionLabel.text = myProjectList[indexPath.row].projectDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //        delete cells here
        if (editingStyle == .delete){
            let doc = myProjectList[indexPath.row].documentId
            
            db.collection(Constants.ProjectList.collectionName).document(doc).delete { (error) in
                if let err = error{
                    print("Error deleting \(err)")
                }else{
                    self.myProjectsTableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let doc = myProjectList[indexPath.row].documentId
        //        load a new controller
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: Constants.myTasksStoryboardId) as! MyTasksViewController
        nextViewController.currentDocumentID = doc
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
}
