# Risk Reward Ratio Calculator

How to calculate Risk Reward Ratio.

## Overview

In this article, we will learn how to calculate Risk Reward Ratio using ``StockCalculator/StockCalculator/calculateRiskRewardRatio(buyPrice:targetPrice:stopLossPrice:)`` method.

```swift
let stockCalculator = StockCalculator()

let riskRewardRatio = stockCalculator.calculateRiskRewardRatio(
    buyPrice: 100,
    targetPrice: 150,
    stopLossPrice: 90
)
```

The code above, will return:

```swift
RiskRewardRatio(risk: 1, reward: 5)
```
