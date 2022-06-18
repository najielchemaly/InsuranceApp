//
//  DashboardViewController.swift
//  insurance
//
//  Created by MR.CHEMALY on 9/9/18.
//  Copyright © 2018 app-loads. All rights reserved.
//

import UIKit

class DashboardViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelCompany: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelExpiry: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var yourInsuranceView: UIView!
    @IBOutlet weak var requestExpertView: UIView!
    @IBOutlet weak var customerSupportView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initializeViews()
//        self.setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeViews() {
        self.labelCompany.text = "Adir"
        self.labelStatus.text = "Active"
        self.labelType.text = "Car Insurance"
        self.labelExpiry.text = "August 19, 2018"
        
        self.progressView.layer.cornerRadius = self.progressView.frame.height/2
        self.progressView.layer.borderColor = Colors.darkBlue.cgColor
        self.progressView.layer.borderWidth = 10
        
        let yourInsuranceTap = UITapGestureRecognizer(target: self, action: #selector(yourInsuranceTapped))
        self.yourInsuranceView.addGestureRecognizer(yourInsuranceTap)
        
        let requestExpertTap = UITapGestureRecognizer(target: self, action: #selector(requestExpertTapped))
        self.requestExpertView.addGestureRecognizer(requestExpertTap)
        
        let customerSupportTap = UITapGestureRecognizer(target: self, action: #selector(customerSupportTapped))
        self.customerSupportView.addGestureRecognizer(customerSupportTap)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.hideMenuView))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.showMenuView))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        if let toolbarView = self.overlayView as? ToolbarView {
            toolbarView.imageViewProfile.layer.cornerRadius = toolbarView.imageViewProfile.frame.height/2
            toolbarView.dashboardView.isHidden = false
            toolbarView.secondView.isHidden = true
            
            let menuTap = UITapGestureRecognizer(target: self, action: #selector(self.showMenuView))
            toolbarView.menuView.addGestureRecognizer(menuTap)
        }
    }
    
    func setupTableView() {
        self.tableView.register(UINib.init(nibName: CellIds.DashboardTableViewCell, bundle: nil), forCellReuseIdentifier: CellIds.DashboardTableViewCell)
        self.tableView.tableFooterView = UIView()
    }
    
    @objc func yourInsuranceTapped() {
        self.redirectToVC(storyboardId: StoryboardIds.YourInsuranceViewController, type: .push)
    }
    
    @objc func requestExpertTapped() {
        self.redirectToVC(storyboardId: StoryboardIds.RequestExpertViewController, type: .push)
    }
    
    @objc func customerSupportTapped() {
        self.redirectToVC(storyboardId: StoryboardIds.CustomerSupportViewController, type: .push)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.DashboardTableViewCell) as? DashboardTableViewCell {
            cell.selectionStyle = .none
            
            switch indexPath.row {
            case 0:                
                cell.backgroundColor = Colors.xlightBlue
                cell.imageViewIcon.image = #imageLiteral(resourceName: "your_insurance_icon")
                cell.labelTitle.text = "YOUR INSURANCE"
            case 1:
                cell.backgroundColor = Colors.lightBlue
                cell.imageViewIcon.image = #imageLiteral(resourceName: "request_expert_icon")
                cell.labelTitle.text = "REQUEST EXPERT"
            case 2:
                cell.backgroundColor = Colors.darkBlue
                cell.imageViewIcon.image = #imageLiteral(resourceName: "customer_support_icon")
                cell.labelTitle.text = "CUSTOMER SUPPORT"
            default:
                break
            }
            
            let cellTap = UITapGestureRecognizer(target: self, action: #selector(didSelectRow(sender:)))
            cell.addGestureRecognizer(cellTap)
            cell.tag = indexPath.row
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    @objc func didSelectRow(sender: UITapGestureRecognizer) {
        if let cell = sender.view {
            switch cell.tag {
            case 0:
                self.redirectToVC(storyboardId: StoryboardIds.YourInsuranceViewController, type: .push)
            case 1:
                self.redirectToVC(storyboardId: StoryboardIds.RequestExpertViewController, type: .push)
            case 2:
                self.redirectToVC(storyboardId: StoryboardIds.CustomerSupportViewController, type: .push)
            default:
                break
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
