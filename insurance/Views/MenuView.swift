//
//  MenuView.swift
//  insurance
//
//  Created by MR.CHEMALY on 9/11/18.
//  Copyright © 2018 app-loads. All rights reserved.
//

import UIKit

class MenuView: UIView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var menuItems: [MenuItem] = [
        MenuItem.init(title: "DASHBOARD", storyboardId: StoryboardIds.DashboardViewController),
        MenuItem.init(title: "MY PROFILE", storyboardId: StoryboardIds.DashboardViewController),
        MenuItem.init(title: "CHANGE PASSWORD", storyboardId: StoryboardIds.ChangePasswordViewController),
        MenuItem.init(title: "SETTINGS", storyboardId: StoryboardIds.DashboardViewController),
        MenuItem.init(title: "LOGOUT", storyboardId: StoryboardIds.SigninNavigationController)
    ]
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func setupTableView() {
        self.tableView.register(UINib.init(nibName: CellIds.MenuTableViewCell, bundle: nil), forCellReuseIdentifier: CellIds.MenuTableViewCell)
        self.tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.MenuTableViewCell) as? MenuTableViewCell {
            cell.selectionStyle = .none
            
            let menuItem = self.menuItems[indexPath.row]
            cell.labelTitle.text = menuItem.title
            
            let cellTap = UITapGestureRecognizer(target: self, action: #selector(didSelectRow(sender:)))
            cell.addGestureRecognizer(cellTap)
            cell.tag = indexPath.row
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    @objc func didSelectRow(sender: UITapGestureRecognizer) {
        if let cell = sender.view, let baseVC = currentVC as? BaseViewController {
            baseVC.hideMenuView()
            
            let menuItem = self.menuItems[cell.tag]
            if menuItem.storyboardId == StoryboardIds.SigninNavigationController {
                baseVC.logout()
                return
            }
            
            if baseVC is DashboardViewController && menuItem.storyboardId != StoryboardIds.DashboardViewController {
                baseVC.redirectToVC(storyboardId: menuItem.storyboardId, type: .push)
            }
        }
    }
    
}

private class MenuItem {
    var title: String!
    var storyboardId: String!
    
    init(title: String, storyboardId: String) {
        self.title = title
        self.storyboardId = storyboardId
    }
}
