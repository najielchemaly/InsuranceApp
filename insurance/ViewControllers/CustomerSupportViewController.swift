//
//  CustomerSupportViewController.swift
//  insurance
//
//  Created by MR.CHEMALY on 9/10/18.
//  Copyright © 2018 app-loads. All rights reserved.
//

import UIKit

class CustomerSupportViewController: BaseViewController {

    @IBOutlet weak var buttonCallUs: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewPolicyNumber: UIView!
    @IBOutlet weak var viewFullName: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPhoneNumber: UIView!
    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var textFieldPolicyNumber: UITextField!
    @IBOutlet weak var textFieldFullName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var textViewMessage: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initializeViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.scrollView.contentSize.height += 20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeViews() {
        self.viewPolicyNumber.customizeLayer()
        self.viewFullName.customizeLayer()
        self.viewEmail.customizeLayer()
        self.viewPhoneNumber.customizeLayer()
        self.viewMessage.customizeLayer()
        self.buttonSubmit.customizeLayer(borderColor: .clear)
        
        if let toolbarView = self.overlayView as? ToolbarView {
            toolbarView.labelTitle.text = "CUSTOMER SUPPORT"
            toolbarView.dashboardView.removeFromSuperview()
            toolbarView.closeView.removeFromSuperview()
        }
    }

    @IBAction func buttonCallUsTapped(_ sender: Any) {
        self.callNumber(number: "0123456789")
    }
    
    @IBAction func buttonSubmitTapped(_ sender: Any) {
        
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

extension UIView {
    func customizeLayer(borderColor: UIColor = Colors.darkBlue) {
        self.layer.cornerRadius = Dimensions.cornerRadiusNormal
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1
    }
}
