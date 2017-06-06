//
//  Params.swift
//  EveryBranch
//
//  Created by Andrew Drechsel on 5/10/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import Foundation

class Params {
    
    var orderno: String?
    var token: String?
    var cryptID: String?
    
    init(orderno: String?, token: String?, cryptID: String?) {
        
        self.orderno = orderno
        self.token = token
        self.cryptID = cryptID
    }
}
