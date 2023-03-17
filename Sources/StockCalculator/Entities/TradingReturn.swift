//
//  File.swift
//  
//
//  Created by Alfin on 07/03/23.
//

import Foundation

public struct TradingReturn: Equatable {
    public let calculationResult: CalculationResult
    public let buyDetail: BuyDetail
    public let sellDetail: SellDetail
    
    public init(
        calculationResult: CalculationResult,
        buyDetail: BuyDetail,
        sellDetail: SellDetail
    ) {
        self.calculationResult = calculationResult
        self.buyDetail = buyDetail
        self.sellDetail = sellDetail
    }
    
    public enum Status {
        case bep, profit, loss
    }
    
    public struct CalculationResult: Equatable {
        public let status: Status
        public let tradingReturn: Double
        public let tradingReturnPercentage: Double
        public let netTradingReturn: Double
        public let netTradingReturnPercentage: Double
        public let totalFee: Double
        public let totalFeePercentage: Double
    }
    
    public struct BuyDetail: Equatable {
        public let lot: Double
        public let buyPrice: Double
        public let buyFee: Double
        public let buyFeePercentage: Double
        public let buyValue: Double
        public let totalPaid: Double
    }
    
    public struct SellDetail: Equatable {
        public let lot: Double
        public let sellPrice: Double
        public let sellFee: Double
        public let sellFeePercentage: Double
        public let sellValue: Double
        public let totalReceived: Double
    }
}
