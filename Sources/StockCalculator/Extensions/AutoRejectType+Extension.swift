//
//  File.swift
//  
//
//  Created by Alfin on 08/03/23.
//

import Foundation

public extension AutoRejectType {
    func getPercentage(price: Double) -> (ara: Double, arb: Double) {
        var limit: Double
        
        switch price {
        case 50..<200:
            limit = 35
            break
        case 200..<5000:
            limit = 25
            break
        default:
            limit = 20
        }
        
        switch self {
        case .symmetric:
            return (ara: limit, arb: -limit)
        case .asymmetric:
            return (ara: limit, arb: -7)
        case .acceleration:
            return (ara: 10, arb: -10)
        }
    }
    
    var arbPrice: Double {
        switch self {
        case .symmetric:
            return 50
        case .asymmetric:
            return 50
        case .acceleration:
            return 0
        }
    }
}
