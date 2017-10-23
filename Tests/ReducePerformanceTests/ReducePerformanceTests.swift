import XCTest
import ReducePerformance

private let n: Int64 = 1_000_000
private let ns = 0..<n
private let squareSum: Int64 = 333332833333500000

class ReducePerformanceTests: XCTestCase {
    func testReduce() {
        measure {
            XCTAssertEqual(ns.reduce(0) { $0 + $1 * $1 }, squareSum)
        }
    }
    
    func testForLoop() {
        measure {
            var result: Int64 = 0
            for n in ns {
                result += n * n
            }
            XCTAssertEqual(result, squareSum)
        }
    }
    
    func testMapReduce() {
        measure {
            XCTAssertEqual(ns.map { $0 * $0 }.reduce(0) { $0 + $1 }, squareSum)
        }
    }
    
    func testLazyMapReduce() {
        measure {
            XCTAssertEqual(ns.lazy.map { $0 * $0 }.reduce(0) { $0 + $1 }, squareSum)
        }
    }
    
    static var allTests = [
        ("testReduce", testReduce),
        ("testForLoop", testForLoop),
        ("testMapReduce", testMapReduce),
        ("testLazyMapReduce", testLazyMapReduce),
    ]
}
