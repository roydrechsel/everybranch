//
//  Staging.swift
//  EveryBranch
//
//  Created by Andrew Drechsel on 12/21/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import Foundation
import UIKit

class Staging
{
    
    static let shared = Staging()
    
    let stagingBranchURL = "http://link.1800contacts.com/"
    var stagingPromoParams: String = ""
    var stagingAutoLoginParam: String = ""
    var stagingOrderno: String = ""
    var stagingCurrentURL: String? = ""
    
    var stagingBadToken: String = "applaunch?token=garbagegarbagegarbage"
    
    var stagingToken: String = "&token=ab83a499-c631-437e-bfe1-7c6904405b58"
    
    var stagingShareableURL = NSURL()
    
    
}
