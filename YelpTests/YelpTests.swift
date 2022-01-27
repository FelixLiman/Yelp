//
//  YelpTests.swift
//  YelpTests
//
//  Created by Felix Liman on 26/01/22.
//

import XCTest
@testable import Yelp

class YelpTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testInsertString() throws {
        var string = "1500"
        string.insert(string: ".", ind: 2)

        XCTAssertEqual(string, "15.00", "this is message")
    }

    func testGetIndexArray() throws {
        let array = ["A", "B", "C", "D", "E", "F"]
        
        XCTAssertEqual(array.get(3), "D", "this is message")
    }

    func testConvertDayOfWeek() throws {
        let day = 3

        XCTAssertEqual(day.convertToDayOfWeek(), "Wednesday", "this is message")
    }
}
