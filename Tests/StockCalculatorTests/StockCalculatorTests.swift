import XCTest
@testable import StockCalculator

final class StockCalculatorTests: XCTestCase {
    let sut: StockCalculator = {
        let sut = StockCalculator()
        sut.sharesPerLot = 100
        return sut
    }()

    func test_calculateTradingReturn() throws {
        let actual = sut.calculateTradingReturn(
            buyPrice: 1000,
            sellPrice: 1200,
            lot: 1,
            brokerFee: BrokerFee(buy: 0.15, sell: 0.25)
        )
        
        let expected = TradingReturn(
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
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_calculateAutoRejects_asymmetric() throws {
        let actual = sut.calculateAutoRejects(
            price: 193,
            type: .asymmetric,
            limit: 1
         )
        
        let expected = AutoRejects(
            ara: [
                AutoReject(price: 260, priceChange: 67, percentage: 34.72, totalPercentage: 34.72),
            ],
            arb: [
                AutoReject(price: 165, priceChange: -28, percentage: -14.51, totalPercentage: -14.51),
            ]
        )
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_calculateAutoRejects_symmetric() throws {
        let actual = sut.calculateAutoRejects(
            price: 150,
            type: .symmetric,
            limit: 2
         )
        
        let expected = AutoRejects(
            ara: [
                AutoReject(price: 202, priceChange: 52, percentage: 34.67, totalPercentage: 34.67),
                AutoReject(price: 252, priceChange: 50, percentage: 24.75, totalPercentage: 68)
            ],
            arb: [
                AutoReject(price: 98, priceChange: -52, percentage: -34.67, totalPercentage: -34.67),
                AutoReject(price: 64, priceChange: -34, percentage: -34.69, totalPercentage: -57.33)
            ]
        )
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_calculateAutoRejects_acceleration() throws {
        let actual = sut.calculateAutoRejects(
            price: 5000,
            type: .acceleration,
            limit: 2
         )
        
        let expected = AutoRejects(
            ara: [
                AutoReject(price: 5500, priceChange: 500, percentage: 10, totalPercentage: 10),
                AutoReject(price: 6050, priceChange: 550, percentage: 10, totalPercentage: 21)
            ],
            arb: [
                AutoReject(price: 4500, priceChange: -500, percentage: -10, totalPercentage: -10),
                AutoReject(price: 4050, priceChange: -450, percentage: -10, totalPercentage: -19)
            ]
        )
        
        XCTAssertEqual(actual, expected)
    }
    
    
    func test_calculateAutoRejects_symmetric_arb() throws {
        let actual = sut.calculateAutoRejects(
            price: 100,
            type: .symmetric,
            limit: 2
         )
        
        let expected = AutoRejects(
            ara: [
                AutoReject(price: 135, priceChange: 35, percentage: 35, totalPercentage: 35),
                AutoReject(price: 182, priceChange: 47, percentage: 34.81, totalPercentage: 82)
            ],
            arb: [
                AutoReject(price: 65, priceChange: -35, percentage: -35, totalPercentage: -35),
                AutoReject(price: 43, priceChange: -22, percentage: -33.85, totalPercentage: -57)
            ]
        )
        
        XCTAssertEqual(actual, expected)
    }
    
    
    func test_calculateAutoRejects_acceleration_arb() throws {
        let actual = sut.calculateAutoRejects(
            price: 55,
            type: .acceleration,
            limit: 2
         )
        
        let expected = AutoRejects(
            ara: [
                AutoReject(price: 60, priceChange: 5, percentage: 9.09, totalPercentage: 9.09),
                AutoReject(price: 66, priceChange: 6, percentage: 10, totalPercentage: 20)
            ],
            arb: [
                AutoReject(price: 50, priceChange: -5, percentage: -9.09, totalPercentage: -9.09),
                AutoReject(price: 45, priceChange: -5, percentage: -10, totalPercentage: -18.18)
            ]
        )
        
        XCTAssertEqual(actual, expected)
    }
    
    
    func test_calculateAutoRejects_symmetric_2() throws {
        let actual = sut.calculateAutoRejects(
            price: 40,
            type: .symmetric,
            limit: 2
         )
        
        let expected = AutoRejects(
            ara: [
                AutoReject(price: 54, priceChange: 14, percentage: 35, totalPercentage: 35),
                AutoReject(price: 72, priceChange: 18, percentage: 33.33, totalPercentage: 80)
            ],
            arb: [
                AutoReject(price: 26, priceChange: -14, percentage: -35, totalPercentage: -35),
                AutoReject(price: 17, priceChange: -9, percentage: -34.62, totalPercentage: -57.5)
            ]
        )
        
        XCTAssertEqual(actual, expected)
    }
    
    
    func test_calculateAutoRejects_acceleration_2() throws {
        let actual = sut.calculateAutoRejects(
            price: 10,
            type: .acceleration,
            limit: 2
         )
        
        let expected = AutoRejects(
            ara: [
                AutoReject(price: 11, priceChange: 1, percentage: 10, totalPercentage: 10),
                AutoReject(price: 12, priceChange: 1, percentage: 9.09, totalPercentage: 20)
            ],
            arb: [
                AutoReject(price: 9, priceChange: -1, percentage: -10, totalPercentage: -10)
            ]
        )
        
        XCTAssertEqual(actual, expected)
    }

    
    func test_calculateAutoRejects_acceleration_3() throws {
        let actual = sut.calculateAutoRejects(
            price: 9,
            type: .acceleration,
            limit: 2
         )
        
        let expected = AutoRejects(
            ara: [],
            arb: []
        )
        
        XCTAssertEqual(actual, expected)
    }

    
    func test_calculateProfitPerTick() throws {
        let actual = sut.calculateProfitPerTick(
            price: 100,
            lot: 1,
            brokerFee: BrokerFee(buy: 0, sell: 0),
            limit: 3
         )
        
        
        let expected = [
            ProfitPerTick(price: 97, percentage: -3, value: -300),
            ProfitPerTick(price: 98, percentage: -2, value: -200),
            ProfitPerTick(price: 99, percentage: -1, value: -100),
            ProfitPerTick(price: 100, percentage: 0, value: 0),
            ProfitPerTick(price: 101, percentage: 1, value: 100),
            ProfitPerTick(price: 102, percentage: 2, value: 200),
            ProfitPerTick(price: 103, percentage: 3, value: 300),
        ]
        
        XCTAssertEqual(actual, expected)
    }
    
    
    func test_calculateProfitPerTick_withBrokerFee() throws {
        let actual = sut.calculateProfitPerTick(
            price: 100,
            lot: 1,
            brokerFee: BrokerFee(buy: 0.15, sell: 0.25),
            limit: 3
         )
        
        
        let expected = [
            ProfitPerTick(price: 97, percentage: -3.39, value: -339),
            ProfitPerTick(price: 98, percentage: -2.39, value: -240),
            ProfitPerTick(price: 99, percentage: -1.4, value: -140),
            ProfitPerTick(price: 100, percentage: -0.4, value: -40),
            ProfitPerTick(price: 101, percentage: 0.6, value: 60),
            ProfitPerTick(price: 102, percentage: 1.59, value: 160),
            ProfitPerTick(price: 103, percentage: 2.59, value: 259),
        ]
        
        XCTAssertEqual(actual, expected)
    }
    
    
    
    func test_calculateAveragePrice() throws {
        let actual = sut.calculateAveragePrice(
            transactions: [
                Transaction(price: 1000, lot: 100, value: 10_000_000),
                Transaction(price: 500, lot: 100, value: 5_000_000)
            ]
        )
        
        let expected = Portfolio(
            lot: 200,
            averagePrice: 750,
            value: 15_000_000
        )
        
        XCTAssertEqual(actual, expected)
    }
    
    
    func test_calculateRiskRewardRatio() throws {
        let actual = sut.calculateRiskRewardRatio(
            buyPrice: 100,
            targetPrice: 150,
            stopLossPrice: 90
        )
        
        let expected = RiskRewardRatio(risk: 1, reward: 5)
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_calculatePriceBookValue() throws {
        let actual = sut.calculatePriceBookValue(
            price: 50,
            bookValue: 200
        )
        
        let expected = 0.25
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_calculateDividenYield() throws {
        let actual = sut.calculateDividenYield(
            price: 100,
            dividen: 25
        )
        
        let expected = 25.0
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_calculateStockSplit() throws {
        let actual = sut.calculateStockSplit(
            price: 1000,
            oldRatio: 100,
            newRatio: 20
        )
        
        let expected = 200.0
        
        XCTAssertEqual(actual, expected)
    }

    
    func test_calculateRightIssue_GLSM() throws {
        let actual = sut.calculateRightIssue(
            ticker: "GLSM",
            cumDatePrice: 800,
            lot: 1000,
            exercisePrice: 250,
            oldRatio: 1000,
            newRatio: 300,
            currentPrice: 675
        )
        
        let expected = RightIssue(
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
        
        
        XCTAssertEqual(actual, expected)
    }
    
   
    func test_calculateRightIssue_BBRI() throws {
        let actual = sut.calculateRightIssue(
            ticker: "BBRI",
            cumDatePrice: 800,
            lot: 1000,
            exercisePrice: 250,
            oldRatio: 1000,
            newRatio: 300
        )
        
        let expected = RightIssue(
            ticker: "BBRI",
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
        
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_calculateLot() throws {
        let actual = sut.calculateLot(
            price: 1000,
            maxBuy: 10_000_000
        )
        
        let expected = LotResult(lot: 100, value: 10_000_000)
        
        XCTAssertEqual(actual, expected)
    }
    
    
    func test_calculateLot_rounded() throws {
        let actual = sut.calculateLot(
            price: 1650,
            maxBuy: 15_000_000
        )
        
        let expected = LotResult(lot: 90, value: 14_850_000)
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_calculateAutoRejects_minPriceFloor() throws {
        let actual = sut.calculateAutoRejects(
            price: 3,
            type: .symmetric,
            limit: 3
        )
        
        let expected = AutoRejects(
            ara: [
                AutoReject(price: 4, priceChange: 1, percentage: 33.33, totalPercentage: 33.33),
                AutoReject(price: 5, priceChange: 1, percentage: 25, totalPercentage: 66.67),
                AutoReject(price: 6, priceChange: 1, percentage: 20, totalPercentage: 100)
            ],
            arb: [
                AutoReject(price: 2, priceChange: -1, percentage: -33.33, totalPercentage: -33.33)
            ]
        )
        
        XCTAssertEqual(actual, expected)
    }
    func test_calculateAutoRejects_customPercentages() {
        let result = sut.calculateAutoRejects(
            price: 1000, type: .symmetric, limit: 2,
            araPercentage: 10, arbPercentage: 5
        )
        XCTAssertEqual(result, AutoRejects(
            ara: [
                AutoReject(price: 1100, priceChange: 100, percentage: 10, totalPercentage: 10),
                AutoReject(price: 1210, priceChange: 110, percentage: 10, totalPercentage: 21)
            ],
            arb: [
                AutoReject(price: 950, priceChange: -50, percentage: -5, totalPercentage: -5),
                AutoReject(price: 905, priceChange: -45, percentage: -4.74, totalPercentage: -9.5)
            ]
        ))
    }

    func test_calculateAutoRejects_independentOverrides() {
        let defaults = sut.calculateAutoRejects(price: 150, type: .symmetric, limit: 2)
        let customAra = sut.calculateAutoRejects(
            price: 150, type: .symmetric, limit: 2, araPercentage: 10
        )
        let customArb = sut.calculateAutoRejects(
            price: 150, type: .symmetric, limit: 2, arbPercentage: 10
        )
        XCTAssertEqual(customAra.ara.map(\.price), [165, 181])
        XCTAssertEqual(customAra.arb, defaults.arb)
        XCTAssertEqual(customArb.ara, defaults.ara)
        XCTAssertEqual(customArb.arb.map(\.price), [135, 122])
    }

    func test_calculateAutoRejects_customPercentageAcrossPriceBands() {
        let result = sut.calculateAutoRejects(
            price: 150, type: .asymmetric, limit: 2,
            araPercentage: 35, arbPercentage: 12.5
        )
        XCTAssertEqual(result.ara.map(\.price), [202, 272])
        XCTAssertEqual(result.arb.map(\.price), [132, 116])
    }

    func test_calculateAutoRejects_zeroPercentages() {
        let defaults = sut.calculateAutoRejects(price: 3, type: .symmetric, limit: 2)
        let custom = sut.calculateAutoRejects(
            price: 3, type: .symmetric, limit: 2, arbPercentage: 0
        )
        XCTAssertEqual(custom.ara, defaults.ara)
        XCTAssertTrue(custom.arb.isEmpty)
        XCTAssertEqual(sut.calculateAutoRejects(
            price: 3, type: .symmetric, limit: 2,
            araPercentage: 0, arbPercentage: 0
        ), AutoRejects(ara: [], arb: []))
    }

    func test_calculateAutoRejects_customPercentageBoundsAndFloor() {
        for type: AutoRejectType in [.idx, .symmetric, .asymmetric, .acceleration] {
            let result = sut.calculateAutoRejects(
                price: 100, type: type, limit: 2,
                araPercentage: 100, arbPercentage: 100
            )
            XCTAssertEqual(result.ara.map(\.price), [200, 400])
            XCTAssertEqual(result.arb.map(\.price), [type.arbPrice])
        }
        for limit in [0, -1] {
            XCTAssertEqual(sut.calculateAutoRejects(
                price: 100, type: .symmetric, limit: limit,
                araPercentage: 10, arbPercentage: 5
            ), AutoRejects(ara: [], arb: []))
        }
    }

    func test_calculateAutoRejects_idx_band1_to_10() throws {
        // Price Rp1–10: Batas ARA dan ARB Rp1
        let actual = sut.calculateAutoRejects(
            price: 5,
            type: .idx,
            limit: 2
        )
        let expected = AutoRejects(
            ara: [
                AutoReject(price: 6, priceChange: 1, percentage: 20, totalPercentage: 20),
                AutoReject(price: 7, priceChange: 1, percentage: 16.67, totalPercentage: 40)
            ],
            arb: [
                AutoReject(price: 4, priceChange: -1, percentage: -20, totalPercentage: -20),
                AutoReject(price: 3, priceChange: -1, percentage: -25, totalPercentage: -40)
            ]
        )
        XCTAssertEqual(actual, expected)

        // Floor at 1: ARB cannot fall below 1
        let floorAt1 = sut.calculateAutoRejects(price: 1, type: .idx, limit: 2)
        XCTAssertEqual(floorAt1.ara.map(\.price), [2, 3])
        XCTAssertEqual(floorAt1.arb, [])

        let floorAt2 = sut.calculateAutoRejects(price: 2, type: .idx, limit: 2)
        XCTAssertEqual(floorAt2.ara.map(\.price), [3, 4])
        XCTAssertEqual(floorAt2.arb.map(\.price), [1])

        // Crossing from 10 into 11: ARA switches from Rp1 to 35%
        let at10 = sut.calculateAutoRejects(price: 10, type: .idx, limit: 2)
        XCTAssertEqual(at10.ara.map(\.price), [11, 14])
        XCTAssertEqual(at10.arb.map(\.price), [9, 8])
    }

    func test_calculateAutoRejects_idx_band11_to_200() throws {
        // Price Rp11–Rp200: Batas ARA 35% dan ARB max(7% or rp -1)
        // For prices where 7% drop < Rp1 (11..14), ARB drops by Rp1
        let actual = sut.calculateAutoRejects(
            price: 11,
            type: .idx,
            limit: 2
        )
        let expected = AutoRejects(
            ara: [
                AutoReject(price: 14, priceChange: 3, percentage: 27.27, totalPercentage: 27.27),
                AutoReject(price: 18, priceChange: 4, percentage: 28.57, totalPercentage: 63.64)
            ],
            arb: [
                AutoReject(price: 10, priceChange: -1, percentage: -9.09, totalPercentage: -9.09),
                AutoReject(price: 9, priceChange: -1, percentage: -10, totalPercentage: -18.18)
            ]
        )
        XCTAssertEqual(actual, expected)

        let at12 = sut.calculateAutoRejects(price: 12, type: .idx, limit: 1)
        XCTAssertEqual(at12.ara.map(\.price), [16])
        XCTAssertEqual(at12.arb.map(\.price), [11])

        let at13 = sut.calculateAutoRejects(price: 13, type: .idx, limit: 1)
        XCTAssertEqual(at13.ara.map(\.price), [17])
        XCTAssertEqual(at13.arb.map(\.price), [12])

        let at14 = sut.calculateAutoRejects(price: 14, type: .idx, limit: 1)
        XCTAssertEqual(at14.ara, [
            AutoReject(price: 18, priceChange: 4, percentage: 28.57, totalPercentage: 28.57)
        ])
        XCTAssertEqual(at14.arb, [
            AutoReject(price: 13, priceChange: -1, percentage: -7.14, totalPercentage: -7.14)
        ])

        // For prices where 7% drop >= Rp1 (15..200), ARB drops by 7%
        let at15 = sut.calculateAutoRejects(price: 15, type: .idx, limit: 2)
        XCTAssertEqual(at15.ara.map(\.price), [20, 27])
        // At 15, ARB 7% goes to 14; at 14, ARB is max(7% or rp -1) which drops Rp1 to 13
        XCTAssertEqual(at15.arb.map(\.price), [14, 13])

        let at100 = sut.calculateAutoRejects(price: 100, type: .idx, limit: 1)
        XCTAssertEqual(at100, AutoRejects(
            ara: [AutoReject(price: 135, priceChange: 35, percentage: 35, totalPercentage: 35)],
            arb: [AutoReject(price: 93, priceChange: -7, percentage: -7, totalPercentage: -7)]
        ))

        let at200 = sut.calculateAutoRejects(price: 200, type: .idx, limit: 1)
        XCTAssertEqual(at200, AutoRejects(
            ara: [AutoReject(price: 270, priceChange: 70, percentage: 35, totalPercentage: 35)],
            arb: [AutoReject(price: 186, priceChange: -14, percentage: -7, totalPercentage: -7)]
        ))
    }

    func test_calculateAutoRejects_idx_bandAbove200_to_5000() throws {
        // Price di atas Rp200–Rp5.000: Batas ARA 25% dan ARB 7%
        let at202 = sut.calculateAutoRejects(price: 202, type: .idx, limit: 1)
        XCTAssertEqual(at202, AutoRejects(
            ara: [AutoReject(price: 252, priceChange: 50, percentage: 24.75, totalPercentage: 24.75)],
            arb: [AutoReject(price: 188, priceChange: -14, percentage: -6.93, totalPercentage: -6.93)]
        ))

        let at1000 = sut.calculateAutoRejects(price: 1000, type: .idx, limit: 1)
        XCTAssertEqual(at1000, AutoRejects(
            ara: [AutoReject(price: 1250, priceChange: 250, percentage: 25, totalPercentage: 25)],
            arb: [AutoReject(price: 930, priceChange: -70, percentage: -7, totalPercentage: -7)]
        ))

        let at5000 = sut.calculateAutoRejects(price: 5000, type: .idx, limit: 1)
        XCTAssertEqual(at5000, AutoRejects(
            ara: [AutoReject(price: 6250, priceChange: 1250, percentage: 25, totalPercentage: 25)],
            arb: [AutoReject(price: 4650, priceChange: -350, percentage: -7, totalPercentage: -7)]
        ))
    }

    func test_calculateAutoRejects_idx_bandAbove5000() throws {
        // Price di atas Rp5.000: Batas ARA 20% dan ARB 7%
        let at5025 = sut.calculateAutoRejects(price: 5025, type: .idx, limit: 1)
        XCTAssertEqual(at5025, AutoRejects(
            ara: [AutoReject(price: 6025, priceChange: 1000, percentage: 19.9, totalPercentage: 19.9)],
            arb: [AutoReject(price: 4680, priceChange: -345, percentage: -6.87, totalPercentage: -6.87)]
        ))

        let at10000 = sut.calculateAutoRejects(price: 10000, type: .idx, limit: 1)
        XCTAssertEqual(at10000, AutoRejects(
            ara: [AutoReject(price: 12000, priceChange: 2000, percentage: 20, totalPercentage: 20)],
            arb: [AutoReject(price: 9300, priceChange: -700, percentage: -7, totalPercentage: -7)]
        ))
    }
}

