import XCTest
@testable import CalculatorProject

final class TestProjectTests: XCTestCase {
    func testExample() {
        let JSONResponse = """
{"time":{"updated":"Jun 4, 2021 14:27:00 UTC","updatedISO":"2021-06-04T14:27:00+00:00","updateduk":"Jun 4, 2021 at 15:27 BST"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","chartName":"Bitcoin","bpi":{"USD":{"code":"USD","symbol":"&#36;","rate":"36,381.3969","description":"United States Dollar","rate_float":36381.3969},"GBP":{"code":"GBP","symbol":"&pound;","rate":"25,642.2270","description":"British Pound Sterling","rate_float":25642.227},"EUR":{"code":"EUR","symbol":"&euro;","rate":"29,869.4179","description":"Euro","rate_float":29869.4179}}}
"""

        guard let data = JSONResponse.data(using: .utf8) else {
            assertionFailure("Failed to convert JSON response")
            return
        }

        let bitCoinPriceIndex = try? JSONDecoder().decode(BitCoinPriceIndex.self, from: data)
        let bitCoinPrice = bitCoinPriceIndex?.bpi.USD.rateValue

        XCTAssertNotNil(bitCoinPrice)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
