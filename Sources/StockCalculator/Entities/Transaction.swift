//
//  File.swift
//  
//
//  Created by Alfin on 27/03/23.
//

import Foundation


public struct Transaction: Equatable {
    public let price: Double
    public let lot: Double
    public let value: Double
    
    public init(price: Double, lot: Double, value: Double) {
        self.price = price
        self.lot = lot
        self.value = value
    }
}
