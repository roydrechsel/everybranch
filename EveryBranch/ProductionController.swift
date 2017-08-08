//
//  ProductionController.swift
//  EveryBranch
//
//  Created by Andrew Drechsel on 6/27/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import Foundation
import UIKit


class ProductionController: UIViewController, SSRadioButtonControllerDelegate {
    
    @IBOutlet weak var productInfoButton: UIButton!
    @IBOutlet weak var autoReorderButton: UIButton!
    @IBOutlet weak var appOrderButton: UIButton!
    @IBOutlet weak var orderHistoryDetailsButton: UIButton!
    @IBOutlet weak var appLaunchButton: UIButton!
    
    @IBOutlet weak var prodPromoOnButton: UIButton!
    @IBOutlet weak var prodPromoOffButton: UIButton!
    @IBOutlet weak var prodValidOrdernoButton: UIButton!
    @IBOutlet weak var prodInvalidOrdernoButton: UIButton!
    @IBOutlet weak var prodCryptidButton: UIButton!
    @IBOutlet weak var prodTokenButton: UIButton!
    
    @IBOutlet weak var prodPromoLabel: UILabel!
    @IBOutlet weak var prodOrdernoLabel: UILabel!
    @IBOutlet weak var prodCryptidTokenLabel: UILabel!
    
    
    let branchURL = "http://link.1800contacts.com/"
    var promoParams: String = ""
    var prodAutoLoginParam: String = ""
    var orderno: String = ""
    
    
    var badToken: String = "applaunch?token=garbagegarbagegarbage"
    
    var prodToken: String = "&token=6ABF8651-AB21-41C9-8EA4-C1D00CC78DE3"
    var prodCryptID: String = "&cryptid=B%2fP8J0RJE0WihD%2bRJ%2f6xSQIzVBjUXJ97eXBBCVEV1octB5dYjI%2f6WGoB406VXEmvk4bz0Waj5lAcGsAGI%2be%2fiE8mXx1zHpI1Kp3dPzKRm3UV6GHlcSX%2bBb20XlXbp9gjG4XPhRUJ%2bxXUgHJapQDj0d5yiK4QVsLvWF0qeKQng17uHz29At47jDVF9U7O6ayPRVhHu5qHXQgPpGhOrHA62IQa3a221P%2fyoTlUVDHaqYEhpUwW4qdPI5qrlh3JdBZRmd1BgQ%2btnVtbayJazv01Xi61AZrAFVs2hzkJ5PFLAcnYPJkcR%2bDckPqh0fQdeCg3hrTtWXUIWtJNWVIz2rdsWQ%3d%3d"
    var prodOrderno: String = "&orderno=0089840229"
    var prodBadOrderno: String = "&orderno=00"
    
    var prodRadioPromoButtonController: SSRadioButtonsController?
    var prodRadioOrdernoButtonController: SSRadioButtonsController?
    var prodRadioCryptidTokenButtonController: SSRadioButtonsController?
    
    override func viewDidLoad() {
        
        prodPromoOnButtonTapped(prodPromoOnButton.isSelected = true)
        prodValidOrdernoButtonTapped(prodValidOrdernoButton.isSelected = true)
        prodCryptidButtonTapped(prodCryptidButton.isSelected = true)
        
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
        
    }
    
    func didSelectButton(selectedButton: UIButton?) {
        NSLog(" \(selectedButton)")
    }
    
    
    @IBAction func prodPromoOnButtonTapped(_ sender: Any) {
        
        promoParams = "&promoid=testPromo&promoisreusable=true&promoexpdate=1586844727000&promoexpseconds=0"
        prodPromoLabel.text = "Valid Promotion    +"
        
    }
    
    @IBAction func prodPromoOffButtonTapped(_ sender: Any) {
        
        promoParams = ""
        prodPromoLabel.text = "No Promotion       +"
    }
    
    @IBAction func prodValidOrdernoButtonTapped(_ sender: Any) {
        
        orderno = prodOrderno
        prodOrdernoLabel.text = "         Valid Orderno        +"
    }
    
    @IBAction func prodInvalidOrdernoButtonTapped(_ sender: Any) {
        
        orderno = prodBadOrderno
        prodOrdernoLabel.text = "         Invalid Orderno      +"
    }
    
    @IBAction func prodCryptidButtonTapped(_ sender: Any) {
        
        prodAutoLoginParam = prodCryptID
        prodCryptidTokenLabel.text = "Cryptid"
    }
    
    @IBAction func prodTokenButtonTapped(_ sender: Any) {
        
        prodAutoLoginParam = prodToken
        prodCryptidTokenLabel.text = "Token"
    }
    
    
    
    @IBAction func productionProductInfoButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)viewProductInfo?productid=000802&promolaunchtext=You+tapped+the+View+Product+link%21\(promoParams)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
        productInfoButton.setTitleColor(UIColor.green, for: UIControlState.normal)
        
    }
    
    @IBAction func productionAutoReorderButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)autoreorderdetails?promolaunchtext=You+tapped+the+Auto-Reorder+link%21\(promoParams)&autoreorderid=69114\(prodAutoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
        autoReorderButton.setTitleColor(UIColor.green, for: UIControlState.normal)
        
    }
    
    @IBAction func productionAppOrderButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)apporder?promolaunchtext=You+tapped+the+App+Order+link%21\(promoParams)\(orderno)\(prodAutoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
        appOrderButton.setTitleColor(UIColor.green, for: UIControlState.normal)
        
    }
    
    @IBAction func productionOrderHistoryDetailsButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)vieworderhistorydetails?promolaunchtext=You+tapped+the+Order+History+Details+link%21\(promoParams)\(orderno)\(prodAutoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
        orderHistoryDetailsButton.setTitleColor(UIColor.green, for: UIControlState.normal)
        
    }
    
    @IBAction func productionAppLaunchButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)applaunch?promolaunchtext=You+tapped+the+App+Launch+link%21\(promoParams)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
        appLaunchButton.setTitleColor(UIColor.green, for: UIControlState.normal)
        
    }
    
    //CREATE A SIGN OUT BUTTON ACTION
}









