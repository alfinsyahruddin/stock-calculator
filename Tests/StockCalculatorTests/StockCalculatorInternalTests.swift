//
//  File.swift
//  
//
//  Created by Alfin on 27/03/23.
//

import XCTest
@testable import StockCalculator

final class StockCalculatorInternalTests: XCTestCase {
    let sut: StockCalculator = {
        let sut = StockCalculator()
        sut.sharesPerLot = 100
        return sut
    }()
    
    
    // MARK: Internal Methods Tests
    
    func test_calculatePercentage() throws {
        let actual = sut.calculatePercentage(25, 100)
        
        let expected: Double = 25
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_getFraction() throws {
        let testCases: [(price: Double, fraction: Double)] = [
            (price: 100, fraction: 1),
            (price: 200, fraction: 2),
            (price: 500, fraction: 5),
            (price: 2000, fraction: 10),
            (price: 5000, fraction: 25)
        ]
        
        for testCase in testCases {
            let actual = sut.getFraction(testCase.price)
            
            let expected: Double = testCase.fraction
            
            XCTAssertEqual(actual, expected)
        }
    }
    
    func test_generateTickers() throws {
        let actual = sut.generateTickers(100, limit: 3)
        
        let expected: [Double] = [
            97,
            98,
            99,
            100,
            101,
            102,
            103
        ]
        
        XCTAssertEqual(actual, expected)
    }
    
    
    func test_getTickerByPercentage() throws {
        let actual = sut.getTickerByPercentage(100, percentage: 35)
        
        let expected: Double = 135
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_handleArb_acceleration() throws {
        let actual = sut.handleArb(
            [
                AutoReject(price: 9, priceChange: -1, percentage: -10, totalPercentage: -10),
                AutoReject(price: 9, priceChange: 0, percentage: 0, totalPercentage: 0),
                AutoReject(price: 9, priceChange: 0, percentage: 0, totalPercentage: 0)
            ],
            type: .acceleration,
            price: 35
        )
        
        let expected: [AutoReject] = [
            AutoReject(price: 9, priceChange: -1, percentage: -10, totalPercentage: -10)
        ]
        
        XCTAssertEqual(actual, expected)
    }
    
    
    
    func test_handleArb_asymmetric() throws {
        let actual = sut.handleArb(
            [
                AutoReject(price: 0, priceChange: -2, percentage: -100, totalPercentage: -100),
            ],
            type: .asymmetric,
            price: 2
        )
        
        let expected: [AutoReject] = [
            AutoReject(price: 1, priceChange: -1, percentage: -50, totalPercentage: -50),
        ]
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_roundedPrice() throws {
        let testCases: [(price: Double, roundedPrice: Double)] = [
//            (price: 673, roundedPrice: 675),
//            (price: 4548, roundedPrice: 4550),
//            (price: 201.5, roundedPrice: 202),
            (price: 200.5, roundedPrice: 200)
        ]
        
        for testCase in testCases {
            let actual = sut.roundedPrice(testCase.price)
            
            let expected = testCase.roundedPrice
            
            XCTAssertEqual(actual, expected)
        }
    }
    
    
    
    func test_autoRejectType_arbPrice() throws {
        XCTAssertEqual(AutoRejectType.symmetric.arbPrice, 1)
        XCTAssertEqual(AutoRejectType.asymmetric.arbPrice, 1)
        XCTAssertEqual(AutoRejectType.acceleration.arbPrice, 0)
    }
    
    func test_autoRejectType_getPercentage() throws {
        // Price < 200 (including 1)
        XCTAssertEqual(AutoRejectType.symmetric.getPercentage(price: 1).ara, 35)
        XCTAssertEqual(AutoRejectType.symmetric.getPercentage(price: 1).arb, -35)
        XCTAssertEqual(AutoRejectType.symmetric.getPercentage(price: 50).ara, 35)
        XCTAssertEqual(AutoRejectType.symmetric.getPercentage(price: 199).ara, 35)
        
        // Price 200..<5000
        XCTAssertEqual(AutoRejectType.symmetric.getPercentage(price: 200).ara, 25)
        XCTAssertEqual(AutoRejectType.symmetric.getPercentage(price: 4999).ara, 25)
        
        // Price >= 5000
        XCTAssertEqual(AutoRejectType.symmetric.getPercentage(price: 5000).ara, 20)
        
        // Asymmetric
        XCTAssertEqual(AutoRejectType.asymmetric.getPercentage(price: 1).arb, -15)
        
        // Acceleration
        XCTAssertEqual(AutoRejectType.acceleration.getPercentage(price: 1).ara, 10)
        XCTAssertEqual(AutoRejectType.acceleration.getPercentage(price: 1).arb, -10)
    }
}

