//
//  File.swift
//  
//
//  Created by Alfin on 27/03/23.
//

import Foundation

public struct RightIssue: Equatable {
    public let ticker: String
    public let value: Double
    public let valueAfterExDate: Double
    public let rightLot: Double
    public let theoreticalPrice: Double
    
    public let redeem: Redeem
    public let notRedeem: NotRedeem
    
    public struct Redeem: Equatable {
        public let lot: Double
        public let averagePrice: Double
        public let redeemCost: Double
        public let marketValue: Double
        public let tradingReturn: Double
        public let tradingReturnPercentage: Double
        public let totalModal: Double
        public let netTradingReturn: Double
        public let netTradingReturnPercentage: Double
    }
    
    public struct NotRedeem: Equatable {
        public let lot: Double
        public let averagePrice: Double
        public let rightPrice: Double
        public let rightLot: Double
        public let rightValue: Double
        public let marketValue: Double
        public let tradingReturn: Double
        public let tradingReturnPercentage: Double
        public let totalModal: Double
        public let netTradingReturn: Double
        public let netTradingReturnPercentage: Double
    }
}
