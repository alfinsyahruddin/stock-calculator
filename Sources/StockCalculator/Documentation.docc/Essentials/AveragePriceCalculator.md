# Average Price Calculator

How to calculate Average Price.

## Overview

In this article, we will learn how to calculate Average Price using ``StockCalculator/StockCalculator/calculateAveragePrice(transactions:)`` method.

```swift
let stockCalculator = StockCalculator()

let portfolio = stockCalculator.calculateAveragePrice(
    transactions: [
        Transaction(price: 1000, lot: 100, value: 10_000_000),
        Transaction(price: 500, lot: 100, value: 5_000_000)
    ]
)
```

The code above, will return:

```swift
Portfolio(
    lot: 200,
    averagePrice: 750,
    value: 15_000_000
)
```
