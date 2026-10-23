//
//  File.swift
//  
//
//  Created by Alfin on 08/03/23.
//

import Foundation

public extension AutoRejectType {
    func getPercentage(price: Double) -> (ara: Double, arb: Double) {
        switch self {
        case .idx:
            let araLimit: Double
            if price <= 200 {
                araLimit = 35
            } else if price <= 5000 {
                araLimit = 25
            } else {
                araLimit = 20
            }
            return (ara: araLimit, arb: -7)
        case .symmetric:
            var limit: Double
            switch price {
            case 1..<200:
                limit = 35
                break
            case 200..<5000:
                limit = 25
                break
            default:
                limit = 20
            }
            return (ara: limit, arb: -limit)
        case .asymmetric:
            var limit: Double
            switch price {
            case 1..<200:
                limit = 35
                break
            case 200..<5000:
                limit = 25
                break
            default:
                limit = 20
            }
            return (ara: limit, arb: -15)
        case .acceleration:
            return (ara: 10, arb: -10)
        }
    }
    
    var arbPrice: Double {
        switch self {
        case .idx:
            return 1
        case .symmetric:
            return 1
        case .asymmetric:
            return 1
        case .acceleration:
            return 0
        }
    }
}
