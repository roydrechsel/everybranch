//
//  EveryBranchTabBarController.swift
//  EveryBranch
//
//  Created by Andrew Drechsel on 4/22/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import UIKit

class EveryBranchTabBarController: UITabBarController {

    let customDelegate = ScrollingTabBarControllerDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = customDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
