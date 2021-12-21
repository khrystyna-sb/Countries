//
//  CountriesTests.swift
//  CountriesTests
//
//  Created by Khrystyna Matasova on 19.11.2021.
//

import XCTest
@testable import Countries

class CountriesTests: XCTestCase {

    func testContainSearchText() throws {
        let searchText = "d"
        let string = "AnDorra"
        let result = string.containSearchText(searchText: searchText)
        XCTAssertEqual(result, true)
    }
}
