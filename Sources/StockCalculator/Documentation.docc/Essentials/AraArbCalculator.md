# ARA & ARB Calculator

How to calculate Auto Rejections (ARA & ARB).
 
## Overview

In this article, we will learn how to calculate Auto Rejections (ARA & ARB) using ``StockCalculator/calculateAutoRejects(price:type:limit:)`` method.

```swift
let stockCalculator = StockCalculator()

let autoRejects = stockCalculator.calculateAutoRejects(
    price: 150,
    type: .symmetric,
    limit: 2
)
```

The code above, will return:

```swift
AutoRejects(
    ara: [
        AutoReject(price: 202, priceChange: 52, percentage: 34.67, totalPercentage: 34.67),
        AutoReject(price: 252, priceChange: 50, percentage: 24.75, totalPercentage: 68)
    ],
    arb: [
        AutoReject(price: 98, priceChange: -52, percentage: -34.67, totalPercentage: -34.67),
        AutoReject(price: 64, priceChange: -34, percentage: -34.69, totalPercentage: -57.33)
    ]
)
```
