//
//  CheckoutScreenUITests.swift
//  CarStoreTests
//
//  Created by Kristiyan Butev on 25.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import FBSnapshotTestCase
@testable import CarStore

class CheckoutScreenUITests: FBSnapshotTestCase
{
    var vc : UIViewController?
    
    override func setUp()
    {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.recordMode = TestConstants.fbRecordMode
        
        self.vc = UIViewController()
    }

    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCheckoutBlank()
    {
        let view = CheckoutView.create(owner: vc!)
        
        view?.setup()
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testCheckoutWithBasket1()
    {
        let view = CheckoutView.create(owner: vc!)
        
        view?.setup()
        
        let viewModel = CheckoutViewModel(carDescriptions: ["BMW x6 for 20000$"], basketDescription: "1 cars, 20000$ total")
        
        view?.update(viewModel: viewModel)
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testCheckoutWithBasket2()
    {
        let view = CheckoutView.create(owner: vc!)
        
        view?.setup()
        
        let viewModel = CheckoutViewModel(carDescriptions: ["BMW x6 for 20000$", "Mercedes w203 for 8000$"], basketDescription: "2 cars, 28000$")
        
        view?.update(viewModel: viewModel)
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testCheckoutWithBasket3()
    {
        let view = CheckoutView.create(owner: vc!)
        
        view?.setup()
        
        let viewModel = CheckoutViewModel(carDescriptions: ["BMW x6 for 20000$", "Mercedes w203 for 8000$", "Toyota rav4 for 12000$", "Dodge FCA US for 6000$"], basketDescription: "4 cars, 46000$ total")
        
        view?.update(viewModel: viewModel)
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
}
