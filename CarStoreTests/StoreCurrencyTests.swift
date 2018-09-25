//
//  StoreCurrencyTests.swift
//  CarStoreTests
//
//  Created by Kristiyan Butev on 25.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import XCTest
@testable import CarStore

class StoreCurrencyTests: XCTestCase
{
    
    override func setUp()
    {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidJSON1() throws
    {
        let defaultCurrency = StoreCurrency(name: .USD, symbol: .USD, exchangeRate: 1.0)
        let desiredCurrencies : [CurrencyName] = [.EUR, .BGN]
        
        let a = try JSONSerialization.data(withJSONObject: ["quotes" : ["USDEUR" : 0.9, "USDBGN" : 2.0]], options: .prettyPrinted)
        
        do
        {
            let _ = try StoreCurrency.initCurrencies(withJSON: a, defaultCurrency: defaultCurrency, desiredCurrencies: desiredCurrencies)
        }
        catch
        {
            XCTFail("Error thrown when trying to construct StoreCurrency with valid JSON")
        }
        
        let b = try JSONSerialization.data(withJSONObject: ["quotes" : ["USDBGN" : 2.0, "USDEUR" : 0.9]], options: .prettyPrinted)
        
        do
        {
            let _ = try StoreCurrency.initCurrencies(withJSON: b, defaultCurrency: defaultCurrency, desiredCurrencies: desiredCurrencies)
        }
        catch
        {
            XCTFail("Error thrown when trying to construct StoreCurrency with valid JSON")
        }
    }
    
    func testInitWithValidJSON2() throws
    {
        let defaultCurrency = StoreCurrency(name: .EUR, symbol: .EUR, exchangeRate: 1.0)
        let desiredCurrencies : [CurrencyName] = [.USD, .BGN]
        
        let a = try JSONSerialization.data(withJSONObject: ["quotes" : ["EURUSD" : 1.1, "EURBGN" : 2.0]], options: .prettyPrinted)
        
        do
        {
            let _ = try StoreCurrency.initCurrencies(withJSON: a, defaultCurrency: defaultCurrency, desiredCurrencies: desiredCurrencies)
        }
        catch
        {
            XCTFail("Error thrown when trying to construct StoreCurrency with valid JSON")
        }
        
        let b = try JSONSerialization.data(withJSONObject: ["quotes" : ["EURBGN" : 2.0, "EURUSD" : 1.1]], options: .prettyPrinted)
        
        do
        {
            let _ = try StoreCurrency.initCurrencies(withJSON: b, defaultCurrency: defaultCurrency, desiredCurrencies: desiredCurrencies)
        }
        catch
        {
            XCTFail("Error thrown when trying to construct StoreCurrency with valid JSON")
        }
    }
    
    func testInitWithInvalidJSON1() throws
    {
        let defaultCurrency = StoreCurrency(name: .USD, symbol: .USD, exchangeRate: 1.0)
        let desiredCurrencies : [CurrencyName] = [.EUR]
        
        let a = try JSONSerialization.data(withJSONObject: [1], options: .prettyPrinted)
        XCTAssertThrowsError(try StoreCurrency.initCurrencies(withJSON: a, defaultCurrency: defaultCurrency, desiredCurrencies: desiredCurrencies))
        
        let b = try JSONSerialization.data(withJSONObject: ["quotes" : []], options: .prettyPrinted)
        XCTAssertThrowsError(try StoreCurrency.initCurrencies(withJSON: b, defaultCurrency: defaultCurrency, desiredCurrencies: desiredCurrencies))
        
        let c = try JSONSerialization.data(withJSONObject: ["quotes" : ["EURUSD" : 1.1]], options: .prettyPrinted)
        XCTAssertThrowsError(try StoreCurrency.initCurrencies(withJSON: c, defaultCurrency: defaultCurrency, desiredCurrencies: desiredCurrencies))
    }
    
    func testInitWithInvalidJSON2() throws
    {
        let defaultCurrency = StoreCurrency(name: .USD, symbol: .USD, exchangeRate: 1.0)
        let desiredCurrencies : [CurrencyName] = [.EUR, .BGN]
        
        let a = try JSONSerialization.data(withJSONObject: ["quotes" : ["USDEUR" : 1.1]], options: .prettyPrinted)
        XCTAssertThrowsError(try StoreCurrency.initCurrencies(withJSON: a, defaultCurrency: defaultCurrency, desiredCurrencies: desiredCurrencies))
    }
}
