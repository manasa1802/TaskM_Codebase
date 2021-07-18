//
//  LaunchScreenViewController.swift
//  TaskM_Codebase
//
//  Created by manasa on 6/25/21.
//  Copyright © 2021 manasa. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
//    @IBOutlet weak var playGifImageView: UIImageView!
    @IBOutlet weak var launchScreenImageView: UIImageView!

    var myTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        view.backgroundColor = UIColor.init(named: "BlueAppColor")
        launchScreenImageView.image = #imageLiteral(resourceName: "LaunchPage")
        
        myTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(moveToNextVC), userInfo: nil, repeats: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func moveToNextVC(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: Constants.loginScreenId) as! LoginViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}
