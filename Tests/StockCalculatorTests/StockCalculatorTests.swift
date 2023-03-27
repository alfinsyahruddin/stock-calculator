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
            price: 100,
            type: .asymmetric,
            limit: 3
         )
        
        let expected = AutoRejects(
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
                AutoReject(price: 50, priceChange: -15, percentage: -23.08, totalPercentage: -50)
            ]
        )
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_calculateAutoRejects_asymmetric_arb() throws {
        let actual = sut.calculateAutoRejects(
            price: 55,
            type: .asymmetric,
            limit: 2
         )
        
        let expected = AutoRejects(
            ara: [
                AutoReject(price: 74, priceChange: 19, percentage: 34.55, totalPercentage: 34.55),
                AutoReject(price: 99, priceChange: 25, percentage: 33.78, totalPercentage: 80)
            ],
            arb: [
                AutoReject(price: 52, priceChange: -3, percentage: -5.45, totalPercentage: -5.45),
                AutoReject(price: 50, priceChange: -2, percentage: -3.85, totalPercentage: -9.09)
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
    

    
    func test_calculateAutoRejects_asymmetric_2() throws {
        let actual = sut.calculateAutoRejects(
            price: 53,
            type: .asymmetric,
            limit: 2
         )
        
        let expected = AutoRejects(
            ara: [
                AutoReject(price: 71, priceChange: 18, percentage: 33.96, totalPercentage: 33.96),
                AutoReject(price: 95, priceChange: 24, percentage: 33.80, totalPercentage: 79.25)
            ],
            arb: [
                AutoReject(price: 50, priceChange: -3, percentage: -5.66, totalPercentage: -5.66)
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
                AutoReject(price: 48, priceChange: 8, percentage: 20, totalPercentage: 20),
                AutoReject(price: 57, priceChange: 9, percentage: 18.75, totalPercentage: 42.50)
            ],
            arb: [

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
    
    func test_calculateAveragePrice() throws {
        let actual = sut.calculateAveragePrice(
            transactions: [
                Transaction(price: 1000, lot: 100, value: 10_000_000),
                Transaction(price: 500, lot: 100, value: 5_000_000)
            ]
        )
        
        let expected = Portfolio(
            lot: 200,
            avgPrice: 750,
            value: 15_000_000
        )
        
        XCTAssertEqual(actual, expected)
    }
    
    
    func test_calculateRightIssue() throws {
        let actual = sut.calculateRightIssue(
            ticker: "BBHI",
            cumDatePrice: 800,
            lot: 1000,
            exercisePrice: 250,
            oldRatio: 1000,
            newRatio: 300,
            currentPrice: 675
        )
        
        let expected = RightIssue(
            value: 80_000_000,
            valueAfterExDate: 67_500_000,
            rightLot: 300,
            redeem: RightIssue.RedeemHMETD(
                lot: 1300,
                avgPrice: 576.9,
                redeemValue: 7_500_000,
                marketValue: 87_750_000,
                tradingReturn: 12_753_000,
                tradingReturnPercentage: 14.53,
                totalModal: 87_500_000,
                netTradingReturn: 250_000,
                netTradingReturnPercentage: 0.28
            ),
            notRedeem: RightIssue.NotRedeemHMETD(
                lot: 1000,
                avgPrice: 675,
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
    
   
}

