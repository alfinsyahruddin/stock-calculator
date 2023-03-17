//
//  File.swift
//  
//
//  Created by Alfin on 08/03/23.
//

import Foundation

extension Double {
    func round() -> Self {
        return (self * 100).rounded() / 100
    }
}
