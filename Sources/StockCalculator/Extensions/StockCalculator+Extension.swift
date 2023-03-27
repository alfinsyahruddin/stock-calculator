//
//  File.swift
//  
//
//  Created by Alfin on 27/03/23.
//

import Foundation

// MARK: - Internal Methods
internal extension StockCalculator {
    func handleAra(_ ara: [AutoReject], type: AutoRejectType, price: Double) -> [AutoReject] {
        let aboveZero = ara.filter { $0.price >= 0 && $0.priceChange > 0 }
        let result: [AutoReject] = aboveZero
        
        return result
    }
    
    
    func handleArb(_ arb: [AutoReject], type: AutoRejectType, price: Double) -> [AutoReject] {
        let aboveZero = arb.filter { $0.price >= 0 && $0.priceChange < 0 }
        let aboveArb = aboveZero.filter { $0.price >= type.arbPrice }
        var result: [AutoReject] = aboveArb
        
        if  (aboveArb.count < aboveZero.count
                && (aboveArb.last?.price ?? 0) > type.arbPrice)
                || (aboveArb.count == 0 && price > type.arbPrice && type != .acceleration)
        {
            let lastPrice = aboveArb.last?.price ?? price
            
            let newPrice = type.arbPrice
            let percentage = self.calculatePercentage(newPrice - lastPrice, lastPrice)
            
            print([
                "price": newPrice,
                "lastPrice": lastPrice,
                "priceChange": newPrice - lastPrice,
                "percentage": percentage,
                "totalPercentage": self.calculatePercentage(newPrice - price, price)
            ])
            result.append(
                AutoReject(
                    price: newPrice,
                    priceChange: newPrice - lastPrice,
                    percentage: percentage,
                    totalPercentage: self.calculatePercentage(newPrice - price, price)
                )
            )
            
        }
        
        return result
    }
    
    func getTickerByPercentage(_ lastPrice: Double, percentage: Double) -> Double {
        let price = (lastPrice * (percentage / 100)) + lastPrice
        
        
        if price.truncatingRemainder(dividingBy: self.getFraction(price)) == 0 {
            print("kena")
            
            return price
        }
        
        var ticker: Double = 0
        
        while self.calculatePercentage(
            (percentage < 0 ? ticker : ticker + self.getFraction(ticker)) - lastPrice,
            lastPrice
        ) < percentage {
            ticker += self.getFraction(ticker)
        }
        
        return ticker
    }
    
    func generateTickers(_ price: Double, limit: Int) -> [Double] {
        // Generate Tickers
        var tickers: [Double] = [price]
        
        // 1. Profit
        for _ in 0..<limit {
            let prevPrice = tickers.last!
            let newPrice = prevPrice + self.getFraction(prevPrice)
            tickers.append(newPrice)
        }
        
        // 2. Loss
        for _ in 0..<limit {
            let prevPrice = tickers.first!
            let newPrice = prevPrice - self.getFraction(prevPrice)
            tickers.insert(newPrice, at: 0)
        }
        
        return tickers
    }
    
    func getFraction(_ price: Double) -> Double {
        switch price {
        case 0..<200:
            return 1
        case 200..<500:
            return 2
        case 500..<2000:
            return 5
        case 2000..<5000:
            return 10
        default:
            return 25
        }
    }
    
    func calculatePercentage(
        _ value: Double,
        _ total: Double
    ) -> Double {
        return ((value / total) * 100).round()
    }
    
    func gcd(_ a: Double, _ b: Double) -> Double {
        return (b == 0) ? a : gcd(b, a.truncatingRemainder(dividingBy: b))
    }
}
