//
//  ProductionController.swift
//  EveryBranch
//
//  Created by Andrew Drechsel on 6/27/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class ProductionController: UIViewController, SSRadioButtonControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var prodBranchPicker: UIPickerView!
    @IBOutlet weak var prodLaunchButton: UIButton!
    @IBOutlet weak var prodBorderLabel: UILabel!
    
    @IBOutlet weak var prodPromoOnButton: UIButton!
    @IBOutlet weak var prodPromoOffButton: UIButton!
    @IBOutlet weak var prodTokenButton: UIButton!
    @IBOutlet weak var prodNoTokenButton: UIButton!
    @IBOutlet weak var prodShareButton: UIButton!

    
    var prodRadioPromoButtonController: SSRadioButtonsController?
    var prodRadioTokenButtonController: SSRadioButtonsController?
    
    var currentUrlString: String? = ""
    var currentPickerSelection: String = ""
    var prodShareableUrl: String = ""
    
    var prodBranchPickerData = ["Select link...", "Product Info", "Auto-Reorder", "App Order", "Order History Details", "App Launch", "ExpressExam New Order"]
    
    
    override func viewDidLoad() {
        
        prodShareButton.contentMode = .center
        prodShareButton.imageView?.contentMode = .scaleAspectFit
        
        prodPromoOnButtonTapped(prodPromoOnButton.isSelected = true)
        prodTokenButtonTapped(prodTokenButton.isSelected = true)
        
        prodRadioPromoButtonController = SSRadioButtonsController(buttons: prodPromoOnButton, prodPromoOffButton)
        prodRadioPromoButtonController?.delegate = self
//        prodRadioPromoButtonController?.shouldLetDeSelect = true
        
        prodRadioTokenButtonController = SSRadioButtonsController(buttons: prodTokenButton, prodNoTokenButton)
        prodRadioTokenButtonController?.delegate = self
//        prodRadioCryptidTokenButtonController?.shouldLetDeSelect = true
//        prodRadioCryptidTokenButtonController?.pressed(UIColor.green)
        
        prodBranchPicker.dataSource = self
        prodBranchPicker.delegate = self
        
        prodBorderLabel.layer.borderColor = UIColor.lightGray.cgColor
        prodBorderLabel.layer.borderWidth = 1
        
        prodLaunchButton.layer.borderColor = UIColor.lightGray.cgColor
        prodLaunchButton.layer.borderWidth = 2
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        
    }
    
    func didSelectButton(selectedButton: UIButton?)
    {
        NSLog("\(String(describing: selectedButton))")
    }
    
    
    @IBAction func prodPromoOnButtonTapped(_ sender: Any)
    {
        
        Production.shared.prodPromoParams = "&promoid=testPromo&promoisreusable=true&promoexpdate=1586844727000&promoexpseconds=0"
        
    }
    
    @IBAction func prodPromoOffButtonTapped(_ sender: Any)
    {
        
        Production.shared.prodPromoParams = ""
    }
    
    @IBAction func prodTokenButtonTapped(_ sender: Any)
    {
        
        Production.shared.prodAutoLoginParam = Production.shared.prodToken
    }
    
    @IBAction func prodNoTokenButtonTapped(_ sender: Any)
    {
        
        Production.shared.prodAutoLoginParam = ""
    }
    
    @IBAction func prodLaunchButtonTapped(_ sender: Any)
    {
        switch currentPickerSelection
        {
            case "Product Info":
                productionProductInfoButtonTapped((Any).self)
            case "Auto-Reorder":
                productionAutoReorderButtonTapped((Any).self)
            case "App Order":
                productionAppOrderButtonTapped((Any).self)
            case "Order History Details":
                productionOrderHistoryDetailsButtonTapped((Any).self)
            case "App Launch":
                productionAppLaunchButtonTapped((Any).self)
            case "ExpressExam New Order":
                productionExpressExamNewOrderButtonTapped((Any).self)
            default:
                break
        }
    }
    
    @IBAction func prodShareSheetButtonTapped(_ sender: Any)
    {
        switch currentPickerSelection
        {
        case "Product Info":
            prodShareableUrl = "\(Production.shared.prodBranchURL)viewProductInfo?productid=000802&promolaunchtext=You+tapped+the+View+Product+link%21\(Production.shared.prodPromoParams)"
        case "Auto-Reorder":
            prodShareableUrl = "\(Production.shared.prodBranchURL)autoreorderdetails?promolaunchtext=You+tapped+the+Auto-Reorder+link%21\(Production.shared.prodPromoParams)&autoreorderid=17799\(Production.shared.prodAutoLoginParam)"
        case "App Order":
            prodShareableUrl = "\(Production.shared.prodBranchURL)apporder?promolaunchtext=You+tapped+the+App+Order+link%21\(Production.shared.prodPromoParams)\(Production.shared.orderno)\(Production.shared.prodAutoLoginParam)"
        case "Order History Details":
            prodShareableUrl = "\(Production.shared.prodBranchURL)vieworderhistorydetails?promolaunchtext=You+tapped+the+Order+History+Details+link%21\(Production.shared.prodPromoParams)\(Production.shared.orderno)\(Production.shared.prodAutoLoginParam)"
        case "App Launch":
            prodShareableUrl = "\(Production.shared.prodBranchURL)applaunch?promolaunchtext=You+tapped+the+App+Launch+link%21\(Production.shared.prodPromoParams)"
        case "ExpressExam New Order":
            prodShareableUrl = "\(Production.shared.prodBranchURL)expressexamneworder?promolaunchtext=You+tapped+the+App+Launch+link%21\(Production.shared.prodPromoParams)"
        default:
            break
        }
        
        if let myWebsite = NSURL(string: prodShareableUrl)
        {
            let objectsToShare = [myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.excludedActivityTypes = [UIActivityType.init(rawValue: "com.apple.reminders.RemindersEditorExtension"), UIActivityType.addToReadingList]
            
            activityVC.popoverPresentationController?.sourceView = sender as? UIView
            self.present(activityVC, animated: true, completion: nil)
            
        }
    }
    
    
    func productionProductInfoButtonTapped(_ sender: Any)
    {
        
        if let url = NSURL(string: "\(Production.shared.prodBranchURL)viewProductInfo?productid=000802&promolaunchtext=You+tapped+the+View+Product+link%21\(Production.shared.prodPromoParams)")
        {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func productionAutoReorderButtonTapped(_ sender: Any)
    {
        
        if let url = NSURL(string: "\(Production.shared.prodBranchURL)autoreorderdetails?promolaunchtext=You+tapped+the+Auto-Reorder+link%21\(Production.shared.prodPromoParams)&autoreorderid=92503\(Production.shared.prodAutoLoginParam)")
        {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func productionAppOrderButtonTapped(_ sender: Any)
    {
        
        if let url = NSURL(string: "\(Production.shared.prodBranchURL)apporder?promolaunchtext=You+tapped+the+App+Order+link%21\(Production.shared.prodPromoParams)\(Production.shared.orderno)\(Production.shared.prodAutoLoginParam)")
        {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func productionOrderHistoryDetailsButtonTapped(_ sender: Any)
    {
        
        if let url = NSURL(string: "\(Production.shared.prodBranchURL)vieworderhistorydetails?promolaunchtext=You+tapped+the+Order+History+Details+link%21\(Production.shared.prodPromoParams)\(Production.shared.orderno)\(Production.shared.prodAutoLoginParam)")
        {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func productionAppLaunchButtonTapped(_ sender: Any)
    {
        
        if let url = NSURL(string: "\(Production.shared.prodBranchURL)applaunch?promolaunchtext=You+tapped+the+App+Launch+link%21\(Production.shared.prodPromoParams)")
        {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func productionExpressExamNewOrderButtonTapped(_ sender: Any)
    {
        if let url = NSURL(string: "\(Production.shared.prodBranchURL)expressexamneworder?promolaunchtext=You+tapped+the+Express+Exam+New+Order+link%21\(Production.shared.prodPromoParams)")
        {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    //MARK: Delegates and Data Sources
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        
        return prodBranchPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        return prodBranchPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        currentPickerSelection = prodBranchPickerData[row]
    }
    
    //CREATE A SIGN OUT BUTTON ACTION
}









