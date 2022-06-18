//
//  YourInsuranceViewController.swift
//  insurance
//
//  Created by MR.CHEMALY on 9/10/18.
//  Copyright © 2018 app-loads. All rights reserved.
//

import UIKit

class YourInsuranceViewController: BaseViewController {
    
    @IBOutlet weak var labelDaysLeftNumber: UILabel!
    @IBOutlet weak var labelCompany: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelExpiry: UILabel!
    @IBOutlet weak var labelCarBrand: UILabel!
    @IBOutlet weak var labelModel: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    
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
        if let toolbarView = self.overlayView as? ToolbarView {
            toolbarView.labelTitle.text = "YOUR INSURANCE"
            toolbarView.dashboardView.removeFromSuperview()
            toolbarView.closeView.removeFromSuperview()
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
