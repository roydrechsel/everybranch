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
    
    static let sharedController = StagingController()
    
    @IBOutlet weak var branchPicker: UIPickerView!
    @IBOutlet weak var launchButton: UIButton!
    @IBOutlet weak var invisibleLabel: UILabel!
    @IBOutlet weak var borderLabel: UILabel!
    @IBOutlet weak var stagingUrlTextField: UITextField!
    
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
    
    var currentUrlString: String? = ""
    var currentPickerSelection: String = ""
    var stagingShareableUrl: String = ""
    
    var branchPickerData = ["Select link...", "Product Info", "Auto-Reorder", "App Order", "Order History Details", "App Launch"]
    
    
    override func viewDidLoad() {
        
        stagingPromoOnButtonTapped(stagingPromoOnButton.isSelected = true)
        stagingValidOrdernoButtonTapped(stagingValidOrdernoButton.isSelected = true)
        stagingTokenButtonTapped(stagingTokenButton.isSelected = true)
        
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
        
        borderLabel.layer.borderColor = UIColor.lightGray.cgColor
        borderLabel.layer.borderWidth = 1
        
        launchButton.layer.borderColor = UIColor.lightGray.cgColor
        launchButton.layer.borderWidth = 2
        
//        guard let stagingUrlString: String = Staging.shared.stagingShareableURL.absoluteString else { return }
//        stagingUrlTextField.text = stagingUrlString
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func didSelectButton(selectedButton: UIButton?) {
        NSLog(" \(selectedButton)")
    }
    
    
    
    @IBAction func stagingShareSheetButtonTapped(_ sender: Any) {
        
        if currentPickerSelection == "Product Info" {
            
            stagingShareableUrl = "\(Staging.shared.branchURL)viewProductInfo?productid=000802&promolaunchtext=You+tapped+the+View+Product+link%21\(Staging.shared.promoParams)"
        } else {
            
            if currentPickerSelection == "Auto-Reorder" {
                
                stagingShareableUrl = "\(Staging.shared.branchURL)autoreorderdetails?promolaunchtext=You+tapped+the+Auto-Reorder+link%21\(Staging.shared.promoParams)&autoreorderid=17799\(Staging.shared.stagingAutoLoginParam)"
            } else {
                
                if currentPickerSelection == "App Order" {
                    
                    stagingShareableUrl = "\(Staging.shared.branchURL)apporder?promolaunchtext=You+tapped+the+App+Order+link%21\(Staging.shared.promoParams)\(Staging.shared.orderno)\(Staging.shared.stagingAutoLoginParam)"
                } else {
                    
                    if currentPickerSelection == "Order History Details" {
                        
                        stagingShareableUrl = "\(Staging.shared.branchURL)vieworderhistorydetails?promolaunchtext=You+tapped+the+Order+History+Details+link%21\(Staging.shared.promoParams)\(Staging.shared.orderno)\(Staging.shared.stagingAutoLoginParam)"
                    } else {
                        
                        if currentPickerSelection == "App Launch" {
                            
                            stagingShareableUrl = "\(Staging.shared.branchURL)applaunch?promolaunchtext=You+tapped+the+App+Launch+link%21\(Staging.shared.promoParams)"
                        }
                    }
                }
            }
        }
        
        if let myWebsite = NSURL(string: stagingShareableUrl) {
            let objectsToShare = [myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //New Excluded Activities Code
//            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            //
            
            activityVC.popoverPresentationController?.sourceView = sender as? UIView
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func stagingPromoOnButtonTapped(_ sender: Any) {
        
        Staging.shared.promoParams = "&promoid=testPromo&promoisreusable=true&promoexpdate=1586844727000&promoexpseconds=0"
    }
    
    @IBAction func stagingPromoOffButtonTapped(_ sender: Any) {
        
        Staging.shared.promoParams = ""
    }
    
    @IBAction func stagingValidOrdernoButtonTapped(_ sender: Any) {
        
        Staging.shared.orderno = Staging.shared.stagingOrderno
    }
    
    @IBAction func stagingInvalidOrdernoButtonTapped(_ sender: Any) {
        
        Staging.shared.orderno = Staging.shared.stagingBadOrderno
    }
    
    @IBAction func stagingCryptidButtonTapped(_ sender: Any) {
        
        Staging.shared.stagingAutoLoginParam = Staging.shared.stagingCryptID
    }
    
    @IBAction func stagingTokenButtonTapped(_ sender: Any) {
        
        Staging.shared.stagingAutoLoginParam = Staging.shared.stagingToken
    }
    
    
    
    @IBAction func launchButtonTapped(_ sender: Any) {
        
        if currentPickerSelection == "Product Info" {
            
            stagingProductInfoButtonTapped((Any).self)
        } else {
            
            if currentPickerSelection == "Auto-Reorder" {
                
                stagingAutoReorderButtonTapped((Any).self)
            } else {
                
                if currentPickerSelection == "App Order" {
                    
                    stagingAppOrderButtonTapped((Any).self)
                } else {
                    
                    if currentPickerSelection == "Order History Details" {
                        
                        stagingOrderHistoryDetailsButtonTapped((Any).self)
                    } else {
                        
                        if currentPickerSelection == "App Launch" {
                            
                            stagingAppLaunchButtonTapped((Any).self)
                        }
                    }
                }
            }
        }
    }
    
    
    func stagingProductInfoButtonTapped(_ sender: Any) {
        
        Staging.shared.stagingViewProductInfoUrl()
    }
    
    func stagingAutoReorderButtonTapped(_ sender: Any) {
        
        Staging.shared.stagingAutoReorderUrl()
    }
    
    func stagingAppOrderButtonTapped(_ sender: Any) {
        
        Staging.shared.stagingAppOrderUrl()
    }
    
    func stagingOrderHistoryDetailsButtonTapped(_ sender: Any) {
        
        Staging.shared.stagingOrderHistoryDetailsUrl()
    }
    
    func stagingAppLaunchButtonTapped(_ sender: Any) {
        
        Staging.shared.stagingAppLaunchUrl()
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
        
        currentPickerSelection = branchPickerData[row]
    }
    
    
    
    //CREATE A SIGN OUT BUTTON ACTION
    
}







