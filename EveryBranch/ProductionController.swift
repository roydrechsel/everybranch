//
//  ProductionController.swift
//  EveryBranch
//
//  Created by Andrew Drechsel on 6/27/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import Foundation
import UIKit


class ProductionController: UIViewController, SSRadioButtonControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var prodBranchPicker: UIPickerView!
    @IBOutlet weak var prodLaunchButton: UIButton!
    @IBOutlet weak var invisibleLabel: UILabel!
    @IBOutlet weak var prodBorderLabel: UILabel!
    
    @IBOutlet weak var prodPromoOnButton: UIButton!
    @IBOutlet weak var prodPromoOffButton: UIButton!
    @IBOutlet weak var prodValidOrdernoButton: UIButton!
    @IBOutlet weak var prodInvalidOrdernoButton: UIButton!
    @IBOutlet weak var prodCryptidButton: UIButton!
    @IBOutlet weak var prodTokenButton: UIButton!
    
    
    let branchURL = "http://link.1800contacts.com/"
    var promoParams: String = ""
    var prodAutoLoginParam: String = ""
    var orderno: String = ""
    
    
    var badToken: String = "applaunch?token=garbagegarbagegarbage"
    
    var prodToken: String = "&token=406E9762-D545-409E-BABB-6D265E05EA4D"
    var prodCryptID: String = "&cryptid=B%2fP8J0RJE0WihD%2bRJ%2f6xSQIzVBjUXJ97eXBBCVEV1octB5dYjI%2f6WGoB406VXEmvk4bz0Waj5lAcGsAGI%2be%2fiE8mXx1zHpI1Kp3dPzKRm3UV6GHlcSX%2bBb20XlXbp9gjG4XPhRUJ%2bxXUgHJapQDj0d5yiK4QVsLvWF0qeKQng17uHz29At47jDVF9U7O6ayPRVhHu5qHXQgPpGhOrHA62IQa3a221P%2fyoTlUVDHaqYEhpUwW4qdPI5qrlh3JdBZRmd1BgQ%2btnVtbayJazv01Xi61AZrAFVs2hzkJ5PFLAcnYPJkcR%2bDckPqh0fQdeCg3hrTtWXUIWtJNWVIz2rdsWQ%3d%3d"
    var prodOrderno: String = "&orderno=0091593038"
    var prodBadOrderno: String = "&orderno=00"
    
    var prodRadioPromoButtonController: SSRadioButtonsController?
    var prodRadioOrdernoButtonController: SSRadioButtonsController?
    var prodRadioCryptidTokenButtonController: SSRadioButtonsController?
    
    var prodBranchPickerData = ["Select link...", "Product Info", "Auto-Reorder", "App Order", "Order History Details", "App Launch"]
    
    
    override func viewDidLoad() {
        
        prodPromoOnButtonTapped(prodPromoOnButton.isSelected = true)
        prodValidOrdernoButtonTapped(prodValidOrdernoButton.isSelected = true)
        prodTokenButtonTapped(prodTokenButton.isSelected = true)
        
        prodRadioPromoButtonController = SSRadioButtonsController(buttons: prodPromoOnButton, prodPromoOffButton)
        prodRadioPromoButtonController?.delegate = self
//        prodRadioPromoButtonController?.shouldLetDeSelect = true
        
        prodRadioOrdernoButtonController = SSRadioButtonsController(buttons: prodValidOrdernoButton, prodInvalidOrdernoButton)
        prodRadioOrdernoButtonController?.delegate = self
//        prodRadioOrdernoButtonController?.shouldLetDeSelect = true
        
        prodRadioCryptidTokenButtonController = SSRadioButtonsController(buttons: prodCryptidButton, prodTokenButton)
        prodRadioCryptidTokenButtonController?.delegate = self
//        prodRadioCryptidTokenButtonController?.shouldLetDeSelect = true
//        prodRadioCryptidTokenButtonController?.pressed(UIColor.green)
        
        prodBranchPicker.dataSource = self
        prodBranchPicker.delegate = self
        
        prodBorderLabel.layer.borderColor = UIColor.lightGray.cgColor
        prodBorderLabel.layer.borderWidth = 1
        
        prodLaunchButton.layer.borderColor = UIColor.lightGray.cgColor
        prodLaunchButton.layer.borderWidth = 2
    }
    
    func didSelectButton(selectedButton: UIButton?) {
        NSLog(" \(selectedButton)")
    }
    
    
    @IBAction func prodPromoOnButtonTapped(_ sender: Any) {
        
        promoParams = "&promoid=testPromo&promoisreusable=true&promoexpdate=1586844727000&promoexpseconds=0"
        
    }
    
    @IBAction func prodPromoOffButtonTapped(_ sender: Any) {
        
        promoParams = ""
    }
    
    @IBAction func prodValidOrdernoButtonTapped(_ sender: Any) {
        
        orderno = prodOrderno
    }
    
    @IBAction func prodInvalidOrdernoButtonTapped(_ sender: Any) {
        
        orderno = prodBadOrderno
    }
    
    @IBAction func prodCryptidButtonTapped(_ sender: Any) {
        
        prodAutoLoginParam = prodCryptID
    }
    
    @IBAction func prodTokenButtonTapped(_ sender: Any) {
        
        prodAutoLoginParam = prodToken
    }
    
    @IBAction func prodLaunchButtonTapped(_ sender: Any) {
        
        if invisibleLabel.text == "Product Info" {
            
            productionProductInfoButtonTapped((Any).self)
        } else {
            
            if invisibleLabel.text == "Auto-Reorder" {
                
                productionAutoReorderButtonTapped((Any).self)
            } else {
                
                if invisibleLabel.text == "App Order" {
                    
                    productionAppOrderButtonTapped((Any).self)
                } else {
                    
                    if invisibleLabel.text == "Order History Details" {
                        
                        productionOrderHistoryDetailsButtonTapped((Any).self)
                    } else {
                        
                        if invisibleLabel.text == "App Launch" {
                            
                            productionAppLaunchButtonTapped((Any).self)
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    func productionProductInfoButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)viewProductInfo?productid=000802&promolaunchtext=You+tapped+the+View+Product+link%21\(promoParams)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func productionAutoReorderButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)autoreorderdetails?promolaunchtext=You+tapped+the+Auto-Reorder+link%21\(promoParams)&autoreorderid=92503\(prodAutoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func productionAppOrderButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)apporder?promolaunchtext=You+tapped+the+App+Order+link%21\(promoParams)\(orderno)\(prodAutoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func productionOrderHistoryDetailsButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)vieworderhistorydetails?promolaunchtext=You+tapped+the+Order+History+Details+link%21\(promoParams)\(orderno)\(prodAutoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func productionAppLaunchButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)applaunch?promolaunchtext=You+tapped+the+App+Launch+link%21\(promoParams)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    //MARK: Delegates and Data Sources
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return prodBranchPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return prodBranchPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        invisibleLabel.text = prodBranchPickerData[row]
    }
    
    //CREATE A SIGN OUT BUTTON ACTION
}









