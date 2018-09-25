//
//  BasketScreenUITests.swift
//  CarStoreTests
//
//  Created by Kristiyan Butev on 25.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import FBSnapshotTestCase
@testable import CarStore

class BasketScreenUITests: FBSnapshotTestCase
{
    var vc : UIViewController?
    var dataSource : BasketViewDataSource?
    
    override func setUp()
    {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.recordMode = TestConstants.fbRecordMode
        
        self.vc = UIViewController()
        self.dataSource = nil
    }
    
    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBasketBlank()
    {
        let view = BasketView.create(owner: vc!)
        
        view?.setup()
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testBasketWithItems1()
    {
        let view = BasketView.create(owner: vc!)
        
        view?.setup()
        
        let viewModel = BasketViewModel(carDescriptions: ["BMW x6 for 20000$"], totalPrice: "20000$ total")
        self.dataSource = BasketViewDataSource(model: viewModel)
        
        view?.update(viewModel: viewModel, dataSource: self.dataSource)
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testBasketWithItems2()
    {
        let view = BasketView.create(owner: vc!)
        
        view?.setup()
        
        let viewModel = BasketViewModel(carDescriptions: ["BMW x6 for 20000$", "Mercedes w203 for 8000$"], totalPrice: "28000$ total")
        self.dataSource = BasketViewDataSource(model: viewModel)
        
        view?.update(viewModel: viewModel, dataSource: self.dataSource)
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testBasketWithItems3()
    {
        let view = BasketView.create(owner: vc!)
        
        view?.setup()
        
        let viewModel = BasketViewModel(carDescriptions: ["BMW x6 for 20000$", "Mercedes w203 for 8000$", "Toyota rav4 for 12000$", "Dodge FCA US for 6000$"], totalPrice: "46000$ total")
        self.dataSource = BasketViewDataSource(model: viewModel)
        
        view?.update(viewModel: viewModel, dataSource: self.dataSource)
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
}
