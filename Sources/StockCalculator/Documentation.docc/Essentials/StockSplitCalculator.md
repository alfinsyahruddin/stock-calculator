# Stock Split Calculator

How to calculate Stock Split.

## Overview

In this article, we will learn how to calculate Stock Split using ``StockCalculator/StockCalculator/calculateStockSplit(price:oldRatio:newRatio:)`` method.

```swift
let stockCalculator = StockCalculator()

let stockSplit = stockCalculator.calculateStockSplit(
    price: 1000,
    oldRatio: 100,
    newRatio: 20
)
```

The code above, will return:

```swift
200
```

