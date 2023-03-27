//
//  File.swift
//  
//
//  Created by Alfin on 27/03/23.
//

import Foundation

public struct RightIssue: Equatable {
    let value: Double
    let valueAfterExDate: Double
    let rightLot: Double
    
    let redeem: Redeem
    let notRedeem: NotRedeem
    
    public struct Redeem: Equatable {
        let lot: Double
        let averagePrice: Double
        let redeemValue: Double
        let marketValue: Double
        let tradingReturn: Double
        let tradingReturnPercentage: Double
        let totalModal: Double
        let netTradingReturn: Double
        let netTradingReturnPercentage: Double
    }
    
    public struct NotRedeem: Equatable {
        let lot: Double
        let averagePrice: Double
        let rightPrice: Double
        let rightLot: Double
        let rightValue: Double
        let marketValue: Double
        let tradingReturn: Double
        let tradingReturnPercentage: Double
        let totalModal: Double
        let netTradingReturn: Double
        let netTradingReturnPercentage: Double
    }
}
