//
//  StagingController.swift
//  EveryBranch
//
//  Created by Andrew Drechsel on 6/27/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class StagingController: UIViewController, SSRadioButtonControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    var container: NSPersistentContainer!
    
    static let sharedController = StagingController()
    
    @IBOutlet weak var branchPicker: UIPickerView!
    @IBOutlet weak var launchButton: UIButton!
    @IBOutlet weak var borderLabel: UILabel!
    
    @IBOutlet weak var stagingPromoOnButton: UIButton!
    @IBOutlet weak var stagingPromoOffButton: UIButton!
    @IBOutlet weak var stagingTokenButton: UIButton!
    @IBOutlet weak var stagingNoTokenButton: UIButton!
    @IBOutlet weak var stagingShareButton: UIButton!
    
    var radioButtonController: SSRadioButtonsController?
    var stagingRadioPromoButtonController: SSRadioButtonsController?
    var stagingRadioTokenButtonController: SSRadioButtonsController?
    
    var currentUrlString: String? = ""
    var currentPickerSelection: String = ""
    var stagingShareableUrl: String = ""
    
    var branchPickerData = ["Select link...", "Product Info", "Auto-Reorder", "App Order", "Order History Details", "App Launch", "ExpressExam New Order"]
    
    
    override func viewDidLoad()
    {
        
//        container = NSPersistentContainer(name: "EveryBranch")
//        container.loadPersistentStores
//            { (NSPersistentStoreDescription, error) in
//                if let error = error
//                {
//                    print("Unresolved error \(error)")
//                }
//            }
        
//        func saveContext()
//        {
//            if container.viewContext.hasChanges
//            {
//                do
//                {
//                    try container.viewContext.save()
//                }
//                catch
//                {
//                    print("There was an issue saving")
//                }
//            }
//        }
        
        stagingShareButton.contentMode = .center
        stagingShareButton.imageView?.contentMode = .scaleAspectFit
        
        stagingPromoOnButtonTapped(stagingPromoOnButton.isSelected = true)
        stagingTokenButtonTapped(stagingTokenButton.isSelected = true)
        
        stagingRadioPromoButtonController = SSRadioButtonsController(buttons: stagingPromoOnButton, stagingPromoOffButton)
        stagingRadioPromoButtonController?.delegate = self
//        stagingRadioPromoButtonController?.shouldLetDeSelect = true
        
        stagingRadioTokenButtonController = SSRadioButtonsController(buttons: stagingTokenButton, stagingNoTokenButton)
        stagingRadioTokenButtonController?.delegate = self
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
    
    override func viewDidAppear(_ animated: Bool)
    {
        
    }
    
    func didSelectButton(selectedButton: UIButton?)
    {
        NSLog("\(selectedButton)")
    }
    
    
    
    @IBAction func stagingShareSheetButtonTapped(_ sender: Any)
    {
        switch currentPickerSelection
        {
        case "Product Info":
            stagingShareableUrl = "\(Staging.shared.stagingBranchURL)viewProductInfo?productid=000802&promolaunchtext=You+tapped+the+View+Product+link%21\(Staging.shared.stagingPromoParams)"
        case "Auto-Reorder":
            stagingShareableUrl = "\(Staging.shared.stagingBranchURL)autoreorderdetails?promolaunchtext=You+tapped+the+Auto-Reorder+link%21\(Staging.shared.stagingPromoParams)&autoreorderid=17799\(Staging.shared.stagingAutoLoginParam)"
        case "App Order":
            stagingShareableUrl = "\(Staging.shared.stagingBranchURL)apporder?promolaunchtext=You+tapped+the+App+Order+link%21\(Staging.shared.stagingPromoParams)\(Staging.shared.stagingOrderno)\(Staging.shared.stagingAutoLoginParam)"
        case "Order History Details":
            stagingShareableUrl = "\(Staging.shared.stagingBranchURL)vieworderhistorydetails?promolaunchtext=You+tapped+the+Order+History+Details+link%21\(Staging.shared.stagingPromoParams)\(Staging.shared.stagingOrderno)\(Staging.shared.stagingAutoLoginParam)"
        case "App Launch":
            stagingShareableUrl = "\(Staging.shared.stagingBranchURL)applaunch?promolaunchtext=You+tapped+the+App+Launch+link%21\(Staging.shared.stagingPromoParams)"
        case "ExpressExam New Order":
            stagingShareableUrl = "\(Staging.shared.stagingBranchURL)expressexamneworder?promolaunchtext=You+tapped+the+App+Launch+link%21\(Staging.shared.stagingPromoParams)"
        default:
            break
        }
        
        if let myWebsite = NSURL(string: stagingShareableUrl)
        {
            let objectsToShare = [myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.excludedActivityTypes = [UIActivityType.init(rawValue: "com.apple.reminders.RemindersEditorExtension"), UIActivityType.addToReadingList]
            
            activityVC.popoverPresentationController?.sourceView = sender as? UIView
            self.present(activityVC, animated: true, completion: nil)
            
        }
    }
        
    
    
    @IBAction func stagingPromoOnButtonTapped(_ sender: Any)
    {
        
        Staging.shared.stagingPromoParams = "&promoid=testPromo&promoisreusable=true&promoexpdate=1586844727000&promoexpseconds=0"
    }
    
    @IBAction func stagingPromoOffButtonTapped(_ sender: Any)
    {
        
        Staging.shared.stagingPromoParams = ""
    }
    
    @IBAction func stagingTokenButtonTapped(_ sender: Any)
    {
        Staging.shared.stagingAutoLoginParam = Staging.shared.stagingToken
    }
    
    @IBAction func stagingNoTokenButtonTapped(_ sender: Any)
    {
        Staging.shared.stagingAutoLoginParam = ""
    }
    
    
    
    @IBAction func launchButtonTapped(_ sender: Any)
    {
        switch currentPickerSelection
        {
            case "Product Info":
                stagingProductInfoButtonTapped((Any).self)
            case "Auto-Reorder":
                stagingAutoReorderButtonTapped((Any).self)
            case "App Order":
                stagingAppOrderButtonTapped((Any).self)
            case "Order History Details":
                stagingOrderHistoryDetailsButtonTapped((Any).self)
            case "App Launch":
                stagingAppLaunchButtonTapped((Any).self)
            case "ExpressExam New Order":
            stagingExpressExamNewOrderButtonTapped((Any).self)
            default:
                break
        }
    }
    // Staging.shared.
    
    func stagingProductInfoButtonTapped(_ sender: Any)
    {
        if let url = NSURL(string: "\(Staging.shared.stagingBranchURL)viewProductInfo?productid=000802&promolaunchtext=You+tapped+the+View+Product+link%21\(Staging.shared.stagingPromoParams)")
        {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            
            let urlString = url.absoluteString
            StagingController.sharedController.currentUrlString = urlString
            //            currentURL = urlString
        }
    }
    
    func stagingAutoReorderButtonTapped(_ sender: Any)
    {
        if let url = NSURL(string: "\(Staging.shared.stagingBranchURL)autoreorderdetails?promolaunchtext=You+tapped+the+Auto-Reorder+link%21\(Staging.shared.stagingPromoParams)&autoreorderid=17799\(Staging.shared.stagingAutoLoginParam)")
        {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func stagingAppOrderButtonTapped(_ sender: Any)
    {
        if let url = NSURL(string: "\(Staging.shared.stagingBranchURL)apporder?promolaunchtext=You+tapped+the+App+Order+link%21\(Staging.shared.stagingPromoParams)\(Staging.shared.stagingOrderno)\(Staging.shared.stagingAutoLoginParam)")
        {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func stagingOrderHistoryDetailsButtonTapped(_ sender: Any)
    {
        if let url = NSURL(string: "\(Staging.shared.stagingBranchURL)vieworderhistorydetails?promolaunchtext=You+tapped+the+Order+History+Details+link%21\(Staging.shared.stagingPromoParams)\(Staging.shared.stagingOrderno)\(Staging.shared.stagingAutoLoginParam)")
        {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func stagingAppLaunchButtonTapped(_ sender: Any)
    {
        if let url = NSURL(string: "\(Staging.shared.stagingBranchURL)applaunch?promolaunchtext=You+tapped+the+App+Launch+link%21\(Staging.shared.stagingPromoParams)")
        {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func stagingExpressExamNewOrderButtonTapped(_ sender: Any)
    {
        if let url = NSURL(string: "\(Staging.shared.stagingBranchURL)expressexamneworder?promolaunchtext=You+tapped+the+Express+Exam+New+Order+link%21\(Staging.shared.stagingPromoParams)")
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
        
        return branchPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        return branchPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        currentPickerSelection = branchPickerData[row]
    }
    
    
    
    //CREATE A SIGN OUT BUTTON ACTION
    
}







