//
//  SigninViewController.swift
//  insurance
//
//  Created by MR.CHEMALY on 9/9/18.
//  Copyright © 2018 app-loads. All rights reserved.
//

import UIKit

class SigninViewController: BaseViewController {

    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonForgotPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initializeViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeViews() {
        self.buttonLogin.layer.cornerRadius = self.buttonLogin.frame.height/2
    }
    
    @IBAction func buttonLoginTapped(_ sender: Any) {
        self.showLoader()
        
        DispatchQueue.global(qos: .background).async {
            _ = appDelegate.services.login(email: "", password: "")
            
            DispatchQueue.main.async {
                self.redirectToVC(storyboardId: StoryboardIds.DashboardViewController, type: .push)
                
                self.hideLoader()
            }
        }
    }
    
    @IBAction func buttonForgotPasswordTapped(_ sender: Any) {
        self.redirectToVC(storyboardId: StoryboardIds.ForgotPasswordViewController, type: .present)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
