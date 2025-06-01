//
//  File.swift
//  stock-calculator
//
//  Created by M Alfin Syahruddin on 01/06/25.
//

import Foundation

public struct LotResult: Equatable {
    public let lot: Double
    public let value: Double
    
    public init(lot: Double, value: Double) {
        self.lot = lot
        self.value = value
    }
}
