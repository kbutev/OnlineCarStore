//
//  SettingsScreenUITests.swift
//  CarStoreTests
//
//  Created by Kristiyan Butev on 25.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import FBSnapshotTestCase
@testable import CarStore

class SettingsScreenUITests: FBSnapshotTestCase
{
    var vc : UIViewController?
    var dataSource : SettingsCurrencyDataSource?
    var delegate : SettingsCurrencyDelegate?
    
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

    func testSettingsBlank()
    {
        let view = SettingsView.create(owner: vc!)
        
        view?.setup()
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testSettingsWithCurrencies1()
    {
        let view = SettingsView.create(owner: vc!)
        
        view?.setup()
        
        let currencies : [CurrencyName] = [.USD]
        
        self.dataSource = SettingsCurrencyDataSource(currencyNames: currencies)
        self.delegate = SettingsCurrencyDelegate(currencyNames: currencies, actionDelegate: nil)
        
        view?.updateCurrencyPicker(dataSource: self.dataSource, delegate: self.delegate)
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testSettingsWithCurrencies2()
    {
        let view = SettingsView.create(owner: vc!)
        
        view?.setup()
        
        let currencies : [CurrencyName] = [.USD, .BGN, .CZK]
        
        self.dataSource = SettingsCurrencyDataSource(currencyNames: currencies)
        self.delegate = SettingsCurrencyDelegate(currencyNames: currencies, actionDelegate: nil)
        
        view?.updateCurrencyPicker(dataSource: self.dataSource, delegate: self.delegate)
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testSettingsWithCurrencies3()
    {
        let view = SettingsView.create(owner: vc!)
        
        view?.setup()
        
        let currencies : [CurrencyName] = [.USD, .BGN, .CZK, .EUR, .BGN]
        
        self.dataSource = SettingsCurrencyDataSource(currencyNames: currencies)
        self.delegate = SettingsCurrencyDelegate(currencyNames: currencies, actionDelegate: nil)
        
        view?.updateCurrencyPicker(dataSource: self.dataSource, delegate: self.delegate)
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testSettingsWithPickedCurrency1()
    {
        let view = SettingsView.create(owner: vc!)
        
        view?.setup()
        
        let currencies : [CurrencyName] = [.USD, .BGN, .CZK, .EUR]
        
        self.dataSource = SettingsCurrencyDataSource(currencyNames: currencies)
        self.delegate = SettingsCurrencyDelegate(currencyNames: currencies, actionDelegate: nil)
        
        view?.updateCurrencyPicker(dataSource: self.dataSource, delegate: self.delegate)
        view?.selectCurrencyPickerValue(row: 1)
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testSettingsWithPickedCurrency2()
    {
        let view = SettingsView.create(owner: vc!)
        
        view?.setup()
        
        let currencies : [CurrencyName] = [.USD, .BGN, .CZK, .EUR]
        
        self.dataSource = SettingsCurrencyDataSource(currencyNames: currencies)
        self.delegate = SettingsCurrencyDelegate(currencyNames: currencies, actionDelegate: nil)
        
        view?.updateCurrencyPicker(dataSource: self.dataSource, delegate: self.delegate)
        view?.selectCurrencyPickerValue(row: 2)
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
    
    func testSettingsWithPickedCurrency3()
    {
        let view = SettingsView.create(owner: vc!)
        
        view?.setup()
        
        let currencies : [CurrencyName] = [.USD, .BGN, .CZK, .EUR]
        
        self.dataSource = SettingsCurrencyDataSource(currencyNames: currencies)
        self.delegate = SettingsCurrencyDelegate(currencyNames: currencies, actionDelegate: nil)
        
        view?.updateCurrencyPicker(dataSource: self.dataSource, delegate: self.delegate)
        view?.selectCurrencyPickerValue(row: 3)
        
        // Test
        let expectation = XCTestExpectation(description: "...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestConstants.waitDelay, execute: {() -> Void in
            self.FBSnapshotVerifyView(view!)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: TestConstants.waitDelay + 0.25)
    }
}
