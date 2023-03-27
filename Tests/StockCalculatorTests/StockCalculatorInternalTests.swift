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
                AutoReject(price: 45, priceChange: -7, percentage: -7, totalPercentage: -14),
            ],
            type: .asymmetric,
            price: 52
        )
        
        let expected: [AutoReject] = [
            AutoReject(price: 50, priceChange: -2, percentage: -3.85, totalPercentage: -3.85),
        ]
        
        XCTAssertEqual(actual, expected)
    }
    
    
    
}

