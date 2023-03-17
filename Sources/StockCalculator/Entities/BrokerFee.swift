//
//  BrokerFee.swift
//  
//
//  Created by Alfin on 07/03/23.
//

import Foundation

public struct BrokerFee: Equatable {
    /// in percentage
    public let buy: Double
    
    /// in percentage
    public let sell: Double
    
    public init(buy: Double, sell: Double) {
        self.buy = buy
        self.sell = sell
    }
}
