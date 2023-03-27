# Profit per Tick Calculator

How to calculate profit or loss in each price tick.
 
## Overview

In this article, we will learn how to calculate Profit per Tick using ``StockCalculator/calculateProfitPerTick(price:lot:brokerFee:limit:)`` method.

```swift
let stockCalculator = StockCalculator()

let profitPerTick = stockCalculator.calculateProfitPerTick(
    price: 100,
    lot: 1,
    brokerFee: BrokerFee(buy: 0, sell: 0),
    limit: 3
)
```

The code above, will return:

```swift
[
    ProfitPerTick(price: 97, percentage: -3, value: -300),
    ProfitPerTick(price: 98, percentage: -2, value: -200),
    ProfitPerTick(price: 99, percentage: -1, value: -100),
    ProfitPerTick(price: 100, percentage: 0, value: 0),
    ProfitPerTick(price: 101, percentage: 1, value: 100),
    ProfitPerTick(price: 102, percentage: 2, value: 200),
    ProfitPerTick(price: 103, percentage: 3, value: 300),
]
```
