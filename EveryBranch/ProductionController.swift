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
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func didSelectButton(selectedButton: UIButton?) {
        NSLog(" \(selectedButton)")
    }
    
    
    @IBAction func prodPromoOnButtonTapped(_ sender: Any) {
        
        Production.shared.promoParams = "&promoid=testPromo&promoisreusable=true&promoexpdate=1586844727000&promoexpseconds=0"
        
    }
    
    @IBAction func prodPromoOffButtonTapped(_ sender: Any) {
        
        Production.shared.promoParams = ""
    }
    
    @IBAction func prodValidOrdernoButtonTapped(_ sender: Any) {
        
        Production.shared.orderno = Production.shared.prodOrderno
    }
    
    @IBAction func prodInvalidOrdernoButtonTapped(_ sender: Any) {
        
        Production.shared.orderno = Production.shared.prodBadOrderno
    }
    
    @IBAction func prodCryptidButtonTapped(_ sender: Any) {
        
        Production.shared.prodAutoLoginParam = Production.shared.prodCryptID
    }
    
    @IBAction func prodTokenButtonTapped(_ sender: Any) {
        
        Production.shared.prodAutoLoginParam = Production.shared.prodToken
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
        
        if let url = NSURL(string: "\(Production.shared.branchURL)viewProductInfo?productid=000802&promolaunchtext=You+tapped+the+View+Product+link%21\(Production.shared.promoParams)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func productionAutoReorderButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(Production.shared.branchURL)autoreorderdetails?promolaunchtext=You+tapped+the+Auto-Reorder+link%21\(Production.shared.promoParams)&autoreorderid=92503\(Production.shared.prodAutoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func productionAppOrderButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(Production.shared.branchURL)apporder?promolaunchtext=You+tapped+the+App+Order+link%21\(Production.shared.promoParams)\(Production.shared.orderno)\(Production.shared.prodAutoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func productionOrderHistoryDetailsButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(Production.shared.branchURL)vieworderhistorydetails?promolaunchtext=You+tapped+the+Order+History+Details+link%21\(Production.shared.promoParams)\(Production.shared.orderno)\(Production.shared.prodAutoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func productionAppLaunchButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(Production.shared.branchURL)applaunch?promolaunchtext=You+tapped+the+App+Launch+link%21\(Production.shared.promoParams)") {
            
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









