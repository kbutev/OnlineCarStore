//
//  StoreProductScreenUITests.swift
//  CarStoreTests
//
//  Created by Kristiyan Butev on 25.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import FBSnapshotTestCase
@testable import CarStore

class ProductScreenUITests: FBSnapshotTestCase
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
    
    func testBlank1()
    {
        let view = ProductView.create(owner: vc!)
        
        view?.setup()
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testCar1()
    {
        let view = ProductView.create(owner: vc!)
        
        view?.setup()
        
        view?.update(viewModel: ProductViewModel(manufacturer: "BMW", model: "x6", description: "The X6 marks BMW's first use of its new Dynamic Performance Control system, which works in unison with xDrive all-wheel drive, both being standard on the X6. DPC is a drivetrain and chassis control system that works to regulate traction and especially correct over- and understeer by actively spreading out drive forces across the rear axle.", topSpeed: "270 km/hr", price: "20000$", imageURL: "https://www.bmw.ca/content/dam/bmw/common/all-models/6-series/gran-turismo/2017/navigation/bmw-6series-granturismo-modelfinder-stage2-890x501.png"))
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testCar2()
    {
        let view = ProductView.create(owner: vc!)
        
        view?.setup()
        
        view?.update(viewModel: ProductViewModel(manufacturer: "Dodge", model: "FCA US", description: "Ram trucks have been named Motor Trend magazine's Truck of the Year five times; the second-generation Ram won the award in 1994, the third-generation Ram Heavy Duty won the award in 2003, the fourth-generation Ram Heavy Duty won in 2010 and the fourth-generation Ram 1500 won in 2013 and 2014.", topSpeed: "120 km/hr", price: "6000$", imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/Ram_1500_Genf_2018.jpg/1920px-Ram_1500_Genf_2018.jpg"))
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testBlank1Landscape()
    {
        let view = ProductView.create(owner: vc!)
        
        view?.setup()
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testCar1Landscape()
    {
        let view = ProductView.create(owner: vc!)
        
        view?.setup()
        
        view?.update(viewModel: ProductViewModel(manufacturer: "BMW", model: "x6", description: "The X6 marks BMW's first use of its new Dynamic Performance Control system, which works in unison with xDrive all-wheel drive, both being standard on the X6. DPC is a drivetrain and chassis control system that works to regulate traction and especially correct over- and understeer by actively spreading out drive forces across the rear axle.", topSpeed: "270 km/hr", price: "20000$", imageURL: "https://www.bmw.ca/content/dam/bmw/common/all-models/6-series/gran-turismo/2017/navigation/bmw-6series-granturismo-modelfinder-stage2-890x501.png"))
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testCar2Landscape()
    {
        let view = ProductView.create(owner: vc!)
        
        view?.setup()
        
        view?.update(viewModel: ProductViewModel(manufacturer: "Dodge", model: "FCA US", description: "Ram trucks have been named Motor Trend magazine's Truck of the Year five times; the second-generation Ram won the award in 1994, the third-generation Ram Heavy Duty won the award in 2003, the fourth-generation Ram Heavy Duty won in 2010 and the fourth-generation Ram 1500 won in 2013 and 2014.", topSpeed: "120 km/hr", price: "6000$", imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/Ram_1500_Genf_2018.jpg/1920px-Ram_1500_Genf_2018.jpg"))
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
}
