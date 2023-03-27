# Trading Return Calculator

How to calculate Trading Return.
 
## Overview

In this article, we will learn how to calculate Trading Return using ``StockCalculator/calculateTradingReturn(buyPrice:sellPrice:lot:brokerFee:)`` method.

```swift
let stockCalculator = StockCalculator()

let tradingReturn = stockCalculator.calculateTradingReturn(
    buyPrice: 1000,
    sellPrice: 1200,
    lot: 1,
    brokerFee: BrokerFee(buy: 0.15, sell: 0.25)
)
```

The code above, will return:

```swift
TradingReturn(
    calculationResult: TradingReturn.CalculationResult(
        status: .profit,
        tradingReturn: 20_000,
        tradingReturnPercentage: 20,
        netTradingReturn: 19_550,
        netTradingReturnPercentage: 19.52,
        totalFee: 450,
        totalFeePercentage: 0.45
    ),
    buyDetail: TradingReturn.BuyDetail(
        lot: 1,
        buyPrice: 1000,
        buyFee: 150,
        buyFeePercentage: 0.15,
        buyValue: 100_000,
        totalPaid: 100_150
    ),
    sellDetail: TradingReturn.SellDetail(
        lot: 1,
        sellPrice: 1200,
        sellFee: 300,
        sellFeePercentage: 0.25,
        sellValue: 120_000,
        totalReceived: 119_700
    )
)
```
