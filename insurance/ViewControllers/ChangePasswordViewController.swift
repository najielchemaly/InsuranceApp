//
//  ChangePasswordViewController.swift
//  insurance
//
//  Created by MR.CHEMALY on 9/10/18.
//  Copyright © 2018 app-loads. All rights reserved.
//

import UIKit

class ChangePasswordViewController: BaseViewController {

    @IBOutlet weak var textFieldOldPassword: UITextField!
    @IBOutlet weak var textFieldNewPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    @IBOutlet weak var buttonSubmit: UIButton!
    
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
        self.buttonSubmit.layer.cornerRadius = self.buttonSubmit.frame.height/2
        
        if let toolbarView = self.overlayView as? ToolbarView {
            toolbarView.labelTitle.text = "CHANGE PASSWORD"
            toolbarView.backgroundColor = .clear
            toolbarView.dashboardView.removeFromSuperview()
            toolbarView.closeView.removeFromSuperview()
        }
    }

    @IBAction func buttonSubmitTapped(_ sender: Any) {
        self.showLoader()
        
        DispatchQueue.global(qos: .background).async {
            _ = appDelegate.services.changePassword(id: "", oldPassword: "", newPassword: "")
            
            DispatchQueue.main.async {
                self.popVC()
                self.hideLoader()
            }
        }
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
