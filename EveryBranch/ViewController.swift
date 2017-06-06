//
//  ViewController.swift
//  EveryBranch
//
//  Created by Andrew Drechsel on 4/13/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var productInfoButton: UIButton!
    @IBOutlet weak var autoReorderButton: UIButton!
    @IBOutlet weak var appOrderButton: UIButton!
    @IBOutlet weak var orderHistoryDetailsButton: UIButton!
    @IBOutlet weak var appLaunchButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBOutlet weak var cryptidTokenSwitch: UISwitch!
    @IBOutlet weak var ordernoSwitch: UISwitch!
    @IBOutlet weak var promoSwitch: UISwitch!
    @IBOutlet weak var environmentSwitch: UISwitch!
    
    @IBOutlet weak var promoLabel: UILabel!
    @IBOutlet weak var ordernoLabel: UILabel!
    @IBOutlet weak var cryptidTokenLabel: UILabel!
    @IBOutlet weak var environmentLabel: UILabel!
    
    let branchURL = "http://link.1800contacts.com/"
    var promoParams: String = ""
    var autoLoginParam: String = ""
    var orderno: String = ""

    
    var badToken: String = "applaunch?token=garbagegarbagegarbage"
    
    var productionToken: String = "&token=6ABF8651-AB21-41C9-8EA4-C1D00CC78DE3"
    var productionCryptID: String = "&cryptid=B%2fP8J0RJE0WihD%2bRJ%2f6xSQIzVBjUXJ97eXBBCVEV1octB5dYjI%2f6WGoB406VXEmvk4bz0Waj5lAcGsAGI%2be%2fiE8mXx1zHpI1Kp3dPzKRm3UV6GHlcSX%2bBb20XlXbp9gjG4XPhRUJ%2bxXUgHJapQDj0d5yiK4QVsLvWF0qeKQng17uHz29At47jDVF9U7O6ayPRVhHu5qHXQgPpGhOrHA62IQa3a221P%2fyoTlUVDHaqYEhpUwW4qdPI5qrlh3JdBZRmd1BgQ%2btnVtbayJazv01Xi61AZrAFVs2hzkJ5PFLAcnYPJkcR%2bDckPqh0fQdeCg3hrTtWXUIWtJNWVIz2rdsWQ%3d%3d"
    var productionOrderno: String = "&orderno=0089840229"

    
    var stagingToken: String = "&token=ab83a499-c631-437e-bfe1-7c6904405b58"
    var stagingCryptID: String = "&cryptid=lkt3BfeydKMRCBC4rK0gkhq4RmAP7EEfspAYx1pxie931dAmZt0pmQxyZxlZwcLv6AemQP0pi%2f%2bYtZ67GuQswqw6TOOxqmx2uy5lo7AYAUum%2bg3BAWuEXijNbygIrnNsff6rohE6f9nIaehlZlzmnH9x6LTPhR9fyZkJUjdsy8Z%2bk6aKHxwNtC9ICJx9zU7IwRJQw4N64C1j4D23EK7gc4lzozAPAWm%2bg9iFW1nhaus8JIqGHdAKmeJRrS2TbVoIUi6T3ZK%2bNzCtFvgsINJYtZQLXmn08bFXyNFXepICZFKpZ6K2YCh5ScPL2TzED0M%2bs2i67f6aj%2bcwk%2fWXPV8Qag%3d%3d"
    var stagingOrderno: String = "&orderno=0030299062"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        environmentSwitchTapped(environmentSwitch.isOn)
        cryptidTokenSwitchTapped(cryptidTokenSwitch.isOn)
        ordernoSwitchTapped(ordernoSwitch.isOn)
        promoSwitchTapped(promoSwitch.isOn)
        
    }
    
    @IBAction func environmentSwitchTapped(_ sender: Any) {
        
        if environmentSwitch.isOn && cryptidTokenSwitch.isOn {
            autoLoginParam = productionToken
            orderno = productionOrderno
            environmentLabel.text = "Production"
            
        } else if environmentSwitch.isOn && !cryptidTokenSwitch.isOn {
            autoLoginParam = productionCryptID
            orderno = productionOrderno
            environmentLabel.text = "Production"
            
        } else if !environmentSwitch.isOn && cryptidTokenSwitch.isOn {
            autoLoginParam = stagingToken
            orderno = stagingOrderno
            environmentLabel.text = "Staging"
            
        } else {
            autoLoginParam = stagingCryptID
            orderno = stagingOrderno
            environmentLabel.text = "Staging"
        }
    }
    
    
    @IBAction func cryptidTokenSwitchTapped(_ sender: Any) {
        
        if cryptidTokenSwitch.isOn && environmentSwitch.isOn {
            autoLoginParam = productionToken
            
            cryptidTokenLabel.text = "Token"
            
        } else if cryptidTokenSwitch.isOn && !environmentSwitch.isOn {
            autoLoginParam = stagingToken
            cryptidTokenLabel.text = "Token"
            
        } else if !cryptidTokenSwitch.isOn && environmentSwitch.isOn {
            autoLoginParam = productionCryptID
            cryptidTokenLabel.text = "CryptID"
            
        } else {
            autoLoginParam = stagingCryptID
            cryptidTokenLabel.text = "CryptID"
            
        }
    }
    
    @IBAction func ordernoSwitchTapped(_ sender: Any) {
        
        if ordernoSwitch.isOn && environmentSwitch.isOn {
            orderno = productionOrderno
            ordernoLabel.text = "Valid Orderno"
            
        } else if ordernoSwitch.isOn && !environmentSwitch.isOn {
            orderno = stagingOrderno
            ordernoLabel.text = "Valid Orderno"
            
        } else {
            orderno = "&orderno=00"
            ordernoLabel.text = "Invalid Orderno"
        }
    }
    
    @IBAction func promoSwitchTapped(_ sender: Any) {
        
        if promoSwitch.isOn {
            promoParams = "&promoid=testPromo&promoisreusable=true&promoexpdate=1586844727000&promoexpseconds=0"
            promoLabel.text = "Promo On"
            
        } else {
            promoParams = ""
            promoLabel.text = "Promo Off"
        }
    }
    
    

    @IBAction func viewProductButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)viewProductInfo?productid=000802&promolaunchtext=You+tapped+the+View+Product+link%21\(promoParams)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
        productInfoButton.setTitleColor(UIColor.green, for: UIControlState.normal)
    }
    
    @IBAction func autoReorderButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)autoreorderdetails?promolaunchtext=You+tapped+the+Auto-Reorder+link%21\(promoParams)&autoreorderid=69114\(autoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
        autoReorderButton.setTitleColor(UIColor.green, for: UIControlState.normal)
    }
    
    @IBAction func appOrderButtonTapped(_ sender: Any) {
        
        let vc = ViewController()
        vc.reloadInputViews()
        
        if let url = NSURL(string: "\(branchURL)apporder?promolaunchtext=You+tapped+the+App+Order+link%21\(promoParams)\(orderno)\(autoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
        appOrderButton.setTitleColor(UIColor.green, for: UIControlState.normal)
    }
        
    @IBAction func orderHistoryDetailsButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)vieworderhistorydetails?promolaunchtext=You+tapped+the+Order+History+Details+link%21\(promoParams)\(orderno)\(autoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
        orderHistoryDetailsButton.setTitleColor(UIColor.green, for: UIControlState.normal)
    }
    
    @IBAction func appLaunchButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)applaunch?promolaunchtext=You+tapped+the+App+Launch+link%21\(promoParams)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
        appLaunchButton.setTitleColor(UIColor.green, for: UIControlState.normal)
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        
        if let url = NSURL(string: "\(branchURL)\(badToken)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }

}

