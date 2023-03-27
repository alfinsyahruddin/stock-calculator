# ARA & ARB Calculator

How to calculate Auto Rejections (ARA & ARB).
 
## Overview

In this article, we will learn how to calculate Auto Rejections (ARA & ARB) using ``StockCalculator/calculateAutoRejects(price:type:limit:)`` method.

```swift
let stockCalculator = StockCalculator()

let autoRejects = stockCalculator.calculateAutoRejects(
    price: 100,
    type: .asymmetric,
    limit: 3
)
```

The code above, will return:

```swift
AutoRejects(
    ara: [
        AutoReject(price: 135, priceChange: 35, percentage: 35, totalPercentage: 35),
        AutoReject(price: 182, priceChange: 47, percentage: 34.81, totalPercentage: 82),
        AutoReject(price: 244, priceChange: 62, percentage: 34.07, totalPercentage: 144)
    ],
    arb: [
        AutoReject(price: 93, priceChange: -7, percentage: -7, totalPercentage: -7),
        AutoReject(price: 87, priceChange: -6, percentage: -6.45, totalPercentage: -13),
        AutoReject(price: 81, priceChange: -6, percentage: -6.9, totalPercentage: -19)
    ]
)
```
