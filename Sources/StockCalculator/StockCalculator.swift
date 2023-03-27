public class StockCalculator {
    
    /// Total shares per Lot, default = 100
    public var sharesPerLot: Double = 100
    
    /// This method is used to create StockCalculator instance.
    public init() {}
    
    /// A method for calculate Trading Return
    public func calculateTradingReturn(
        buyPrice: Double,
        sellPrice: Double,
        lot: Double,
        brokerFee: BrokerFee = BrokerFee(buy: 0, sell: 0)
    ) -> TradingReturn {
        let buyValue = buyPrice * (lot * self.sharesPerLot)
        let buyFee = buyValue * (brokerFee.buy / 100)
        let totalPaid = buyValue + buyFee
        
        let sellValue = sellPrice * (lot * self.sharesPerLot)
        let sellFee = sellValue * (brokerFee.sell / 100)
        let totalReceived = sellValue - sellFee
        
        let tradingReturn = sellValue - buyValue
        let totalFee = buyFee + sellFee
        let netTradingReturn = tradingReturn - totalFee
        
        return TradingReturn(
            calculationResult: TradingReturn.CalculationResult(
                status: netTradingReturn > 0 ? .profit : netTradingReturn < 0 ? .loss : .bep,
                tradingReturn: tradingReturn,
                tradingReturnPercentage: calculatePercentage(tradingReturn, buyValue),
                netTradingReturn: netTradingReturn,
                netTradingReturnPercentage: calculatePercentage(netTradingReturn, totalPaid),
                totalFee: totalFee,
                totalFeePercentage: calculatePercentage(totalFee, totalPaid)
            ),
            buyDetail: TradingReturn.BuyDetail(
                lot: lot,
                buyPrice: buyPrice,
                buyFee: buyFee,
                buyFeePercentage: brokerFee.buy,
                buyValue: buyValue,
                totalPaid: totalPaid
            ),
            sellDetail: TradingReturn.SellDetail(
                lot: lot,
                sellPrice: sellPrice,
                sellFee: sellFee,
                sellFeePercentage: brokerFee.sell,
                sellValue: sellValue,
                totalReceived: totalReceived
            )
        )
    }
    
    /// A method for calculate Auto Rejections (ARA & ARB)
    public func calculateAutoRejects(
        price: Double,
        type: AutoRejectType,
        limit: Int = 5
    ) -> AutoRejects {
        var ara: [AutoReject] = []
        var arb: [AutoReject] = []

        // ARA
        for _ in 0..<limit {
            let lastPrice = ara.last?.price ?? price
            
            let newPrice = self.getTickerByPercentage(lastPrice, percentage: type.getPercentage(price: lastPrice).ara)
            let percentage = self.calculatePercentage(newPrice - lastPrice, lastPrice)
                    
            ara.append(
                AutoReject(
                    price: newPrice,
                    priceChange: newPrice - lastPrice,
                    percentage: percentage,
                    totalPercentage: self.calculatePercentage(newPrice - price, price)
                )
            )
        }
        
        
        // ARB
        for _ in 0..<limit {
            let lastPrice = arb.last?.price ?? price
            
            let newPrice = self.getTickerByPercentage(lastPrice, percentage: type.getPercentage(price: lastPrice).arb)
            let percentage = self.calculatePercentage(newPrice - lastPrice, lastPrice)
                    
            arb.append(
                AutoReject(
                    price: newPrice,
                    priceChange: newPrice - lastPrice,
                    percentage: percentage,
                    totalPercentage: self.calculatePercentage(newPrice - price, price)
                )
            )
        }
        
       
        
        return AutoRejects(
            ara: self.handleAra(ara, type: type, price: price),
            arb: self.handleArb(arb, type: type, price: price)
        )
    }
    
    /// A method for calculate profit or loss in each price tick.
    public func calculateProfitPerTick(
        price: Double,
        lot: Double,
        brokerFee: BrokerFee = BrokerFee(buy: 0, sell: 0),
        limit: Int = 5
    ) -> [ProfitPerTick] {
        let tickers = self.generateTickers(price, limit: limit)
        
        let results: [ProfitPerTick] = tickers.map { tick in
            let tradingReturn = self.calculateTradingReturn(buyPrice: price, sellPrice: tick, lot: lot, brokerFee: brokerFee)
            return ProfitPerTick(
                price: tick,
                percentage: tradingReturn.calculationResult.netTradingReturnPercentage,
                value: tradingReturn.calculationResult.netTradingReturn.rounded()
            )
        }
       
        return results.filter { $0.price >= 0 }
    }
    
    /// A method for calculate Risk Reward Ratio
    public func calculateRiskRewardRatio(
        buyPrice: Double,
        targetPrice: Double,
        stopLossPrice: Double
    ) -> RiskRewardRatio {
        let risk = abs(stopLossPrice - buyPrice)
        let reward = targetPrice - buyPrice
        let ratio = gcd(risk, reward)
        
        return RiskRewardRatio(
            risk: risk / ratio,
            reward: reward / ratio
        )
    }
}


