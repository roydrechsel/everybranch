//
//  Staging.swift
//  EveryBranch
//
//  Created by Andrew Drechsel on 12/21/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import Foundation
import UIKit

class Staging {
    
    static let shared = Staging()
    
    let branchURL = "http://link.1800contacts.com/"
    var promoParams: String = ""
    var stagingAutoLoginParam: String = ""
    var orderno: String = ""
    var currentURL: String? = ""
    
    var badToken: String = "applaunch?token=garbagegarbagegarbage"
    
    var stagingToken: String = "&token=ab83a499-c631-437e-bfe1-7c6904405b58"
    var stagingCryptID: String =  "&cryptid=oQEKfvq8aXennnJ1v35rg92NgZWhWa%2b8d760RGibo4cNFij7m9HrREt84t3nRGslsLiDtgFoWEC7zsrjKTf2V2cPccvR5YUhTHCSGwIo9s5WtqQX8MX4qwHn2FnwpNpC9wmHbeFS8L8UqpU6uO%2bm1CRuVETG9UWHydUUszD8kwWTF9FNBPTJ5mxRdqUZ9whtvSWK4ZPQCcoYkz8ufJux220Y6u62ZuZv9cVOwn0cwr%2b8yCKagU%2b3s6rwbp1qqHzTd4BiPbKQpNHf8C0octDZfSybA27ucrOrrduMwWLxR1LwzXCMsa1vc08bNLxciNU6DKXKwSZST8Lxbz%2fd6%2bOutQ%3d%3d"
    var stagingOrderno: String = "&orderno=0030299062"
    var stagingBadOrderno: String = "&orderno=00"
    var stagingShareableURL = NSURL()
    
    
    func stagingViewProductInfoUrl() {
        if let url = NSURL(string: "\(branchURL)viewProductInfo?productid=000802&promolaunchtext=You+tapped+the+View+Product+link%21\(promoParams)") {
        
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            
            let urlString = url.absoluteString
            StagingController.sharedController.currentUrlString = urlString
//            currentURL = urlString
        }
    }
    
    func stagingAutoReorderUrl() {
        if let url = NSURL(string: "\(branchURL)autoreorderdetails?promolaunchtext=You+tapped+the+Auto-Reorder+link%21\(promoParams)&autoreorderid=17799\(stagingAutoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func stagingAppOrderUrl() {
        if let url = NSURL(string: "\(branchURL)apporder?promolaunchtext=You+tapped+the+App+Order+link%21\(promoParams)\(orderno)\(stagingAutoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func stagingOrderHistoryDetailsUrl() {
        if let url = NSURL(string: "\(branchURL)vieworderhistorydetails?promolaunchtext=You+tapped+the+Order+History+Details+link%21\(promoParams)\(orderno)\(stagingAutoLoginParam)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
    }
    
    func stagingAppLaunchUrl() {
        if let url = NSURL(string: "\(branchURL)applaunch?promolaunchtext=You+tapped+the+App+Launch+link%21\(promoParams)") {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
}
