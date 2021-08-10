//
//  SignUpViewController.swift
//  TaskM_Codebase
//
//  Created by manasa on 6/28/21.
//  Copyright © 2021 manasa. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var signupView: UIView!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var emailIdField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    @IBOutlet weak var facebookSignInButton: UIButton!
    @IBOutlet weak var twitterSignInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.image = #imageLiteral(resourceName: "BackgroundImage")
        signupView.layer.cornerRadius = 15
        signupButton.layer.cornerRadius = 10
        //        text field delegates
        emailIdField.delegate = self
        passwordField.delegate = self
        //        google sign in
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        if let email = emailIdField.text, let password = passwordField.text{
            
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, err) in
                if let errror = err{
                    print(errror)
                }else{
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextVC = storyboard.instantiateViewController(identifier: Constants.myProjectScreenID) as MyProjectsViewController
                    self.navigationController?.pushViewController(nextVC, animated: true)
//                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(nextVC)
                }
            }
        }
    }
    
    @IBAction func goBackToLoginButtonPressed(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: Constants.loginScreenId) as! LoginViewController
//        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(nextViewController)
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func signUpWithGoogleButtonPressed(_ sender: UIButton) {
        
////        credentials are obtained from appdelegate class
//        Auth.auth().signIn(with: credential) { authResult, error in
//            if let error = error {
//                let authError = error as NSError
//                if isMFAEnabled, authError.code == AuthErrorCode.secondFactorRequired.rawValue {
//                    // The user is a multi-factor user. Second factor challenge is required.
//                    let resolver = authError
//                        .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
//                    var displayNameString = ""
//                    for tmpFactorInfo in resolver.hints {
//                        displayNameString += tmpFactorInfo.displayName ?? ""
//                        displayNameString += " "
//                    }
//                    self.showTextInputPrompt(
//                        withMessage: "Select factor to sign in\n\(displayNameString)",
//                        completionBlock: { userPressedOK, displayName in
//                            var selectedHint: PhoneMultiFactorInfo?
//                            for tmpFactorInfo in resolver.hints {
//                                if displayName == tmpFactorInfo.displayName {
//                                    selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
//                                }
//                            }
//                            PhoneAuthProvider.provider()
//                                .verifyPhoneNumber(with: selectedHint!, uiDelegate: nil,
//                                                   multiFactorSession: resolver
//                                                    .session) { verificationID, error in
//                                                        if error != nil {
//                                                            print(
//                                                                "Multi factor start sign in failed. Error: \(error.debugDescription)"
//                                                            )
//                                                        } else {
//                                                            self.showTextInputPrompt(
//                                                                withMessage: "Verification code for \(selectedHint?.displayName ?? "")",
//                                                                completionBlock: { userPressedOK, verificationCode in
//                                                                    let credential: PhoneAuthCredential? = PhoneAuthProvider.provider()
//                                                                        .credential(withVerificationID: verificationID!,
//                                                                                    verificationCode: verificationCode!)
//                                                                    let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator
//                                                                        .assertion(with: credential!)
//                                                                    resolver.resolveSignIn(with: assertion!) { authResult, error in
//                                                                        if error != nil {
//                                                                            print(
//                                                                                "Multi factor finanlize sign in failed. Error: \(error.debugDescription)"
//                                                                            )
//                                                                        } else {
//                                                                            self.navigationController?.popViewController(animated: true)
//                                                                        }
//                                                                    }
//                                                            }
//                                                            )
//                                                        }
//                            }
//                    }
//                    )
//                } else {
//                    //              self.showMessagePrompt(error.localizedDescription)
//                    return
//                }
//                // ...
//                return
//            }
//            // User is signed in
//            // ...
//        }
    }
}
