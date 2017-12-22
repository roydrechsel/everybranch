//
//  Production.swift
//  EveryBranch
//
//  Created by Andrew Drechsel on 12/21/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import Foundation
import UIKit

class Production {
    
    static let shared = Production()
    
    let branchURL = "http://link.1800contacts.com/"
    var promoParams: String = ""
    var prodAutoLoginParam: String = ""
    var orderno: String = ""
    
    var badToken: String = "applaunch?token=garbagegarbagegarbage"
    
    var prodToken: String = "&token=406E9762-D545-409E-BABB-6D265E05EA4D"
    var prodCryptID: String = "&cryptid=B%2fP8J0RJE0WihD%2bRJ%2f6xSQIzVBjUXJ97eXBBCVEV1octB5dYjI%2f6WGoB406VXEmvk4bz0Waj5lAcGsAGI%2be%2fiE8mXx1zHpI1Kp3dPzKRm3UV6GHlcSX%2bBb20XlXbp9gjG4XPhRUJ%2bxXUgHJapQDj0d5yiK4QVsLvWF0qeKQng17uHz29At47jDVF9U7O6ayPRVhHu5qHXQgPpGhOrHA62IQa3a221P%2fyoTlUVDHaqYEhpUwW4qdPI5qrlh3JdBZRmd1BgQ%2btnVtbayJazv01Xi61AZrAFVs2hzkJ5PFLAcnYPJkcR%2bDckPqh0fQdeCg3hrTtWXUIWtJNWVIz2rdsWQ%3d%3d"
    var prodOrderno: String = "&orderno=0091593038"
    var prodBadOrderno: String = "&orderno=00"
}
