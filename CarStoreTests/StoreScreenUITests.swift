//
//  StoreScreenUITests.swift
//  CarStoreTests
//
//  Created by Kristiyan Butev on 25.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import FBSnapshotTestCase
@testable import CarStore

class StoreScreenUITests: FBSnapshotTestCase
{
    var vc : UIViewController?
    var dataSource : StoreViewDataSource?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.recordMode = TestConstants.fbRecordMode
        
        self.vc = UIViewController()
        self.dataSource = nil
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStoreBlank()
    {
        let view = StoreView.create(owner: vc!)
        
        view?.setup()
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testStoreWithEmptyBasketTest1()
    {
        let view = StoreView.create(owner: vc!)
        
        view?.setup()
        
        let viewModel = StoreViewModel(carDescriptions: ["BMW x6 for 20000$", "Mercedes w203 for 8000$", "Toyota rav4 for 12000$", "Dodge FCA US for 6000$"], basketDescription: "Empty basket")
        
        self.dataSource = StoreViewDataSource(viewModel: viewModel)
        
        view?.updateStore(dataSource: self.dataSource)
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testStoreWithEmptyBasketTest2()
    {
        let view = StoreView.create(owner: vc!)
        
        view?.setup()
        
        let viewModel = StoreViewModel(carDescriptions: ["BMW x6 for 20000$", "Mercedes w203 for 8000$", "Toyota rav4 for 12000$", "Dodge FCA US for 6000$", "BMW x6 for 20000$", "Mercedes w203 for 8000$", "Toyota rav4 for 12000$", "Dodge FCA US for 6000$", "BMW x6 for 20000$", "Mercedes w203 for 8000$", "Toyota rav4 for 12000$", "Dodge FCA US for 6000$"], basketDescription: "Empty basket")
        
        self.dataSource = StoreViewDataSource(viewModel: viewModel)
        
        view?.updateStore(dataSource: self.dataSource)
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testStoreWithBasketTest1()
    {
        let view = StoreView.create(owner: vc!)
        
        view?.setup()
        
        let viewModel = StoreViewModel(carDescriptions: ["BMW x6 for 20000$", "Mercedes w203 for 8000$", "Toyota rav4 for 12000$", "Dodge FCA US for 6000$"], basketDescription: "Basket: 1 cars, 12000$ total")
        
        self.dataSource = StoreViewDataSource(viewModel: viewModel)
        
        view?.updateStore(dataSource: self.dataSource)
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testStoreWithBasketTest2()
    {
        let view = StoreView.create(owner: vc!)
        
        view?.setup()
        
        let viewModel = StoreViewModel(carDescriptions: ["BMW x6 for 20000$", "Mercedes w203 for 8000$", "Toyota rav4 for 12000$", "Dodge FCA US for 6000$", "BMW x6 for 20000$", "Mercedes w203 for 8000$", "Toyota rav4 for 12000$", "Dodge FCA US for 6000$", "BMW x6 for 20000$", "Mercedes w203 for 8000$", "Toyota rav4 for 12000$", "Dodge FCA US for 6000$"], basketDescription: "Basket: 1 cars, 12000$ total")
        
        self.dataSource = StoreViewDataSource(viewModel: viewModel)
        
        view?.updateStore(dataSource: self.dataSource)
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
}
