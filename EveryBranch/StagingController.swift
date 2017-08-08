//
//  StagingController.swift
//  EveryBranch
//
//  Created by Andrew Drechsel on 6/27/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import Foundation
import UIKit


class StagingController: UIViewController, SSRadioButtonControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var branchPicker: UIPickerView!
    @IBOutlet weak var launchButton: UIButton!
    @IBOutlet weak var invisibleLabel: UILabel!
    
    @IBOutlet weak var stagingPromoOnButton: UIButton!
    @IBOutlet weak var stagingPromoOffButton: UIButton!
    @IBOutlet weak var stagingValidOrdernoButton: UIButton!
    @IBOutlet weak var stagingInvalidOrdernoButton: UIButton!
    @IBOutlet weak var stagingCryptidButton: UIButton!
    @IBOutlet weak var stagingTokenButton: UIButton!
    
    var radioButtonController: SSRadioButtonsController?
    var stagingRadioPromoButtonController: SSRadioButtonsController?
    var stagingRadioOrdernoButtonController: SSRadioButtonsController?
    var stagingRadioCryptidTokenButtonController: SSRadioButtonsController?
    
    var branchPickerData = ["Select link...", "Product Info", "Auto-Reorder", "App Order", "Order History Details", "App Launch"]
    
    
    override func viewDidLoad() {
        
        stagingPromoOnButtonTapped(stagingPromoOnButton.isSelected = true)
        stagingValidOrdernoButtonTapped(stagingValidOrdernoButton.isSelected = true)
        stagingCryptidButtonTapped(stagingCryptidButton.isSelected = true)
        
        stagingRadioPromoButtonController = SSRadioButtonsController(buttons: stagingPromoOnButton, stagingPromoOffButton)
        stagingRadioPromoButtonController?.delegate = self
//        stagingRadioPromoButtonController?.shouldLetDeSelect = true
        
        stagingRadioOrdernoButtonController = SSRadioButtonsController(buttons: stagingValidOrdernoButton, stagingInvalidOrdernoButton)
        stagingRadioOrdernoButtonController?.delegate = self
//        stagingRadioOrdernoButtonController?.shouldLetDeSelect = true
        
        stagingRadioCryptidTokenButtonController = SSRadioButtonsController(buttons: stagingCryptidButton, stagingTokenButton)
        stagingRadioCryptidTokenButtonController?.delegate = self
//        stagingRadioCryptidTokenButtonController?.shouldLetDeSelect = true

        branchPicker.dataSource = self
        branchPicker.delegate = self
    }
    
    func didSelectButton(selectedButton: UIButton?) {
        NSLog(" \(selectedButton)")
    }
    
    
    let branchURL = "http://link.1800contacts.com/"
    var promoParams: String = ""
    var stagingAutoLoginParam: String = ""
    var orderno: String = ""
    
    
    var badToken: String = "applaunch?token=garbagegarbagegarbage"    
    
    var stagingToken: String = "&token=ab83a499-c631-437e-bfe1-7c6904405b58"
    var stagingCryptID: String =  "&cryptid=oQEKfvq8aXennnJ1v35rg92NgZWhWa%2b8d760RGibo4cNFij7m9HrREt84t3nRGslsLiDtgFoWEC7zsrjKTf2V2cPccvR5YUhTHCSGwIo9s5WtqQX8MX4qwHn2FnwpNpC9wmHbeFS8L8UqpU6uO%2bm1CRuVETG9UWHydUUszD8kwWTF9FNBPTJ5mxRdqUZ9whtvSWK4ZPQCcoYkz8ufJux220Y6u62ZuZv9cVOwn0cwr%2b8yCKagU%2b3s6rwbp1qqHzTd4BiPbKQpNHf8C0octDZfSybA27ucrOrrduMwWLxR1LwzXCMsa1vc08bNLxciNU6DKXKwSZST8Lxbz%2fd6%2bOutQ%3d%3d"
    var stagingOrderno: String = "&orderno=0030299062"
    var stagingBadOrderno: String = "&orderno=00"
    
    
    
    
    
    @IBAction func stagingPromoOnButtonTapped(_ sender: Any) {
        
        promoParams = "&promoid=testPromo&promoisreusable=true&promoexpdate=1586844727000&promoexpseconds=0"
    }
    
    @IBAction func stagingPromoOffButtonTapped(_ sender: Any) {
        
        promoParams = ""
    }
    
    @IBAction func stagingValidOrdernoButtonTapped(_ sender: Any) {
        
        orderno = stagingOrderno
    }
    
    @IBAction func stagingInvalidOrdernoButtonTapped(_ sender: Any) {
        
        orderno = stagingBadOrderno
    }
    
    @IBAction func stagingCryptidButtonTapped(_ sender: Any) {
        
        stagingAutoLoginParam = stagingCryptID
    }
    
    @IBAction func stagingTokenButtonTapped(_ sender: Any) {
        
        stagingAutoLoginParam = stagingToken
    }
    
    
    
    @IBAction func launchButtonTapped(_ sender: Any) {
        
        if invisibleLabel.text == "Product Info" {
            
            stagingProductInfoButtonTapped((Any).self)
        } else {
            
            if invisibleLabel.text == "Auto-Reorder" {
                
                stagingAutoReorderButtonTapped((Any).self)
            } else {
                
                if invisibleLabel.text == "App Order" {
                    
                    stagingAppOrderButtonTapped((Any).self)
                } else {
                    
                    if invisibleLabel.text == "Order History Details" {
                        
                        stagingOrderHistoryDetailsButtonTapped((Any).self)
                    } else {
                        
                        if invisibleLabel.text == "App Launch" {
                            
                            stagingAppLaunchButtonTapped((Any).self)
                        }
                    }
                }
            }
        }
    }
    
    
    func stagingProductInfoButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)viewProductInfo?productid=000802&promolaunchtext=You+tapped+the+View+Product+link%21\(promoParams)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func stagingAutoReorderButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)autoreorderdetails?promolaunchtext=You+tapped+the+Auto-Reorder+link%21\(promoParams)&autoreorderid=17799\(stagingAutoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func stagingAppOrderButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)apporder?promolaunchtext=You+tapped+the+App+Order+link%21\(promoParams)\(orderno)\(stagingAutoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func stagingOrderHistoryDetailsButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)vieworderhistorydetails?promolaunchtext=You+tapped+the+Order+History+Details+link%21\(promoParams)\(orderno)\(stagingAutoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func stagingAppLaunchButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)applaunch?promolaunchtext=You+tapped+the+App+Launch+link%21\(promoParams)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    //MARK: Delegates and Data Sources
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return branchPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return branchPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        invisibleLabel.text = branchPickerData[row]
    }
    
    
    
    //CREATE A SIGN OUT BUTTON ACTION
    
}







