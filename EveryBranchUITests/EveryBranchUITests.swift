//
//  EveryBranchUITests.swift
//  EveryBranchUITests
//
//  Created by Andrew Drechsel on 4/13/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import XCTest

class EveryBranchUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let app = XCUIApplication()
        
        app.launch()
        
        app.buttons["Order History Details"].tap()
        
        app.launch()
        
//        app.buttons["Sign Out"].tap()
//        
//        app.launch()
        
        app.buttons["App Launch"].tap()
        
        app.launch()
        
        app.buttons["Product Info"].tap()
       
        app.launch()
        
        app.buttons["Auto-Reorder"].tap()
        
        app.launch()
        
        app.buttons["App Order"].tap()
        
        app.launch()
        
    }
    
}
