# ARA & ARB Calculator

How to calculate Auto Rejections (ARA & ARB).
 
## Overview

In this article, we will learn how to calculate Auto Rejections (ARA & ARB) using ``StockCalculator/calculateAutoRejects(price:type:limit:araPercentage:arbPercentage:)`` method.

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

## IDX Rules

Use `.idx` to calculate Auto Rejections under Indonesia Stock Exchange (IDX) regulations:
- Harga saham Rp1–10: Batas ARA dan ARB Rp1
- Harga saham Rp11–Rp200: Batas ARA 35% dan ARB max(7% or rp -1)
- Harga saham di atas Rp200–Rp5.000: Batas ARA 25% dan ARB 7%
- Harga saham di atas Rp5.000: Batas ARA 20% dan ARB 7%

```swift
let autoRejects = stockCalculator.calculateAutoRejects(
    price: 11,
    type: .idx,
    limit: 2
)
// ARA: 14 (35%), 18 (35%)
// ARB: 10 (Rp1), 9 (Rp1)
```

## Custom percentages

Set either or both percentages to override the selected type. Enter positive
percentage points: `araPercentage: 25` means a 25% rise and `arbPercentage: 15`
means a 15% fall. Values must be finite and in `0...100`; invalid values fail a
precondition. A value of zero returns no movements for that side. A nonpositive
`limit` returns empty results.

```swift
let autoRejects = stockCalculator.calculateAutoRejects(
    price: 1000,
    type: .symmetric,
    limit: 2,
    araPercentage: 10,
    arbPercentage: 5
)
// ARA prices: [1100, 1210]
// ARB prices: [950, 905]
```

Each override stays fixed across all steps, including when the price crosses a
price band. An omitted (or `nil`) override retains the selected type's defaults.
Tick rounding and the selected type's minimum price still apply, so the returned
percentage may differ from the requested percentage.
