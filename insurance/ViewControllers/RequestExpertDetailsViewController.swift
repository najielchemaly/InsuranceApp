//
//  RequestExpertDetailsViewController.swift
//  insurance
//
//  Created by MR.CHEMALY on 9/10/18.
//  Copyright © 2018 app-loads. All rights reserved.
//

import UIKit

class RequestExpertDetailsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var buttonDropDown: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldDistrict: UITextField!
    
    var pickerView: UIPickerView!
    
    var districts: [String] = [
        "BEIRUT",
        "ALEY",
        "BAABDA",
        "CHOUF",
        "JBEIL",
        "KESERWAN",
        "MATC"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initializeViews()
        self.setupPickerView()
        self.setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeViews() {
        self.buttonDropDown.layer.cornerRadius = Dimensions.cornerRadiusNormal
        
        if let toolbarView = self.overlayView as? ToolbarView {
            toolbarView.labelTitle.text = "REQUEST EXPERT"
            toolbarView.dashboardView.removeFromSuperview()
            toolbarView.backView.removeFromSuperview()
        }
    }
    
    func setupPickerView() {
        self.pickerView = UIPickerView()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.textFieldDistrict.inputView = self.pickerView
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        toolbar.sizeToFit()
        toolbar.barStyle = .default
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        cancelButton.tintColor = Colors.darkBlue
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneButtonTapped))
        doneButton.tintColor = Colors.darkBlue
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.items = [cancelButton, flexibleSpace, doneButton]
        
        self.textFieldDistrict.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        let row = self.pickerView.selectedRow(inComponent: 0)
        self.textFieldDistrict.text = self.districts[row]
        
        self.dismissKeyboard()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.districts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.districts[row]
    }
    
    func setupTableView() {
        self.tableView.register(UINib.init(nibName: CellIds.RequestExpertDetailsTableViewCell, bundle: nil), forCellReuseIdentifier: CellIds.RequestExpertDetailsTableViewCell)
        self.tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.RequestExpertDetailsTableViewCell) as? RequestExpertDetailsTableViewCell {
            cell.selectionStyle = .none
            
            let phoneTap = UITapGestureRecognizer(target: self, action: #selector(phoneTapped(sender:)))
            cell.viewPhone.addGestureRecognizer(phoneTap)
            cell.viewPhone.tag = indexPath.row
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    @objc func phoneTapped(sender: UITapGestureRecognizer) {
        if let view = sender.view {
            self.callNumber(number: "0123456789")
        }
    }
    
    @IBAction func buttonDropDownTapped(_ sender: Any) {
        
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
