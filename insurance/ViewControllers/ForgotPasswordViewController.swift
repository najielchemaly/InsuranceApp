//
//  ForgotPasswordViewController.swift
//  insurance
//
//  Created by MR.CHEMALY on 9/14/18.
//  Copyright © 2018 app-loads. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var buttonReset: UIButton!
    
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
        self.buttonReset.layer.cornerRadius = self.buttonReset.frame.height/2
    }
    
    @IBAction func buttonResetTapped(_ sender: Any) {
        self.showLoader()
        
        DispatchQueue.global(qos: .background).async {
            _ = appDelegate.services.forgotPassword(email: "")
            
            DispatchQueue.main.async {
                self.dismissVC()
                self.hideLoader()
            }
        }
    }
    
    @IBAction func buttonCancelTapped(_ sender: Any) {
        self.dismissVC()
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
