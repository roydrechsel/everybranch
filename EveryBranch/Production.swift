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
    
    let prodBranchURL = "http://link.1800contacts.com/"
    var prodPromoParams: String = ""
    var prodAutoLoginParam: String = ""
    var orderno: String = ""
    
    var prodBadToken: String = "applaunch?token=garbagegarbagegarbage"
    
    var prodToken: String = "&token=406E9762-D545-409E-BABB-6D265E05EA4D"
    
    var prodOrderno: String = "&orderno=0091593038"
    var prodBadOrderno: String = "&orderno=00"
}
