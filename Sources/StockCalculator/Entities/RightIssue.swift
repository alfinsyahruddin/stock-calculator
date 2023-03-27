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
    
    let redeem: RedeemHMETD
    let notRedeem: NotRedeemHMETD
    
    public struct RedeemHMETD: Equatable {
        let lot: Double
        let avgPrice: Double
        let redeemValue: Double
        let marketValue: Double
        let tradingReturn: Double
        let tradingReturnPercentage: Double
        let totalModal: Double
        let netTradingReturn: Double
        let netTradingReturnPercentage: Double
    }
    
    public struct NotRedeemHMETD: Equatable {
        let lot: Double
        let avgPrice: Double
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
