//
//  ViewController.swift
//  insurance
//
//  Created by MR.CHEMALY on 9/9/18.
//  Copyright © 2018 app-loads. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.shared.isStatusBarHidden = true
        
        if self.hasToolbar() {
            self.setupToolbar()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currentVC = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hasToolbar() -> Bool {
        if self is DashboardViewController || self is ChangePasswordViewController || self is YourInsuranceViewController || self is RequestExpertViewController || self is RequestExpertDetailsViewController || self is CustomerSupportViewController {
            return true
        }
        
        return false
    }

    var overlayView: UIView!
    func setupToolbar() {
        let view = Bundle.main.loadNibNamed("ToolbarView", owner: self.view, options: nil)
        if let toolbarView = view?.first as? ToolbarView {
            self.overlayView = toolbarView
            self.overlayView.frame.size.width = self.view.frame.size.width
            self.overlayView.frame.origin = CGPoint(x: 0, y: 0)
            self.view.addSubview(self.overlayView)
            
            let backTap = UITapGestureRecognizer(target: self, action: #selector(self.popVC))
            toolbarView.backView.addGestureRecognizer(backTap)
            
            let closeTap = UITapGestureRecognizer(target: self, action: #selector(self.dismissVC))
            toolbarView.closeView.addGestureRecognizer(closeTap)
        }
    }
    
    func callNumber(number: String) {
        let phoneNumber = number
        guard let numberUrl = URL(string: "tel://" + phoneNumber.replacingOccurrences(of: " ", with: "")) else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(numberUrl)
        } else {
            UIApplication.shared.openURL(numberUrl)
        }
    }
    
    @objc func showMenuView() {
        let view = Bundle.main.loadNibNamed("MenuView", owner: self.view, options: nil)
        if let menuView = view?.first as? MenuView {
            menuView.setupTableView()
            self.overlayView = menuView
            self.overlayView.frame.size.width = self.view.frame.size.width
            self.overlayView.frame.origin = CGPoint(x: -self.overlayView.frame.size.width, y: 0)
            self.view.addSubview(self.overlayView)

            UIView.animate(withDuration: 0.3, animations: {
                self.overlayView.frame.origin.x = 0
            })
        }
    }
    
    @objc func hideMenuView() {
        if let menuView = self.overlayView as? MenuView {
            UIView.animate(withDuration: 0.3, animations: {
                menuView.frame.origin.x = -menuView.frame.width
            }, completion: { success in
                menuView.removeFromSuperview()
            })
        }
    }
    
    @objc func logout() {
        self.showLoader()
        
        let userId = currentUser.id
        DispatchQueue.global(qos: .background).async {
            _ = appDelegate.services.logout(id: String(describing: userId))
            
            DispatchQueue.main.async {
                let userDefaults = UserDefaults.standard
                userDefaults.removeObject(forKey: "user")
                userDefaults.removeObject(forKey: "isUserLoggedIn")
                userDefaults.synchronize()
                
                if let window = appDelegate.window {
                    if let signinNavigationBarController = self.storyboard?.instantiateViewController(withIdentifier: StoryboardIds.SigninNavigationController) as? UINavigationController  {
                        window.rootViewController = signinNavigationBarController
                    }
                }
                
                self.hideLoader()
            }
        }
    }
    
    func showLoader(message: String? = nil, type: NVActivityIndicatorType? = .ballScaleMultiple,
                    color: UIColor? = nil , textColor: UIColor? = nil) {
        let activityData = ActivityData(message: message, type: type, color: color, textColor: textColor)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        self.dismissKeyboard()
    }
    
    func hideLoader() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    func showToast(message: String) {
        let labelMessage = UILabel(frame: CGRect(x: 0, y: 0, width: message.width(withConstrainedHeight: 30, font: Fonts.textFont_Bold), height: 30))
        labelMessage.center = self.view.center
        labelMessage.frame.origin.y = self.view.frame.height-50
        labelMessage.layer.cornerRadius = labelMessage.frame.height/2
        labelMessage.layer.masksToBounds = true
        labelMessage.backgroundColor = Colors.white
        labelMessage.textColor = Colors.textDarkBlue
        labelMessage.textAlignment = .center
        labelMessage.text = message
        
        labelMessage.alpha = 0
        self.view.addSubview(labelMessage)
        
        UIView.animate(withDuration: 0.8, animations: {
            labelMessage.alpha = 1
        }, completion: { success in
            if #available(iOS 10.0, *) {
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { timer in
                    UIView.animate(withDuration: 0.5, animations: {
                        labelMessage.alpha = 0
                    })
                })
            } else {
                // Fallback on earlier versions
            }
        })
    }

}

