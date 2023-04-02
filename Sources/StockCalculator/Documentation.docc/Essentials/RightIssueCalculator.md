# Right Issue Calculator

How to calculate Right Issue.

## Overview

In this article, we will learn how to calculate Right Issue using ``StockCalculator/StockCalculator/calculateRightIssue(ticker:cumDatePrice:lot:exercisePrice:oldRatio:newRatio:currentPrice:)`` method.

```swift
let stockCalculator = StockCalculator()

let rightIssue = stockCalculator.calculateRightIssue(
    ticker: "GLSM",
    cumDatePrice: 800,
    lot: 1000,
    exercisePrice: 250,
    oldRatio: 1000,
    newRatio: 300
)
```

The code above, will return:

```swift
RightIssue(
    ticker: "GLSM",
    value: 80_000_000,
    valueAfterExDate: 67_500_000,
    rightLot: 300,
    theoreticalPrice: 675,
    redeem: RightIssue.Redeem(
        lot: 1300,
        averagePrice: 576.92,
        redeemCost: 7_500_000,
        marketValue: 87_750_000,
        tradingReturn: 12_750_400,
        tradingReturnPercentage: 14.53,
        totalModal: 87_500_000,
        netTradingReturn: 250_000,
        netTradingReturnPercentage: 0.28
    ),
    notRedeem: RightIssue.NotRedeem(
        lot: 1000,
        averagePrice: 675,
        rightPrice: 425,
        rightLot: 300,
        rightValue: 12_750_000,
        marketValue: 67_500_000,
        tradingReturn: 0,
        tradingReturnPercentage: 0,
        totalModal: 80_000_000,
        netTradingReturn: 250_000,
        netTradingReturnPercentage: 0.31
    )
)
```
