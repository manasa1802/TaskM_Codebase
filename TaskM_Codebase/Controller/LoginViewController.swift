//
//  LoginViewController.swift
//  TaskM_Codebase
//
//  Created by manasa on 6/28/21.
//  Copyright © 2021 manasa. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UIViewControllerTransitioningDelegate, UITextFieldDelegate {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //    animation
    let transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.image = #imageLiteral(resourceName: "BackgroundImage")
        loginView.layer.cornerRadius = 15
        loginButton.layer.cornerRadius = 10
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
                if let err = error{
                    print(err)
                }else{
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: Constants.myProjectScreenID) as! MyProjectsViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
            }
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = loginButton.center
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = loginButton.center
        return transition
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: Constants.signUpId) as! SignUpViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}
