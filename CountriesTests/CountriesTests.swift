//
//  CountriesTests.swift
//  CountriesTests
//
//  Created by Khrystyna Matasova on 19.11.2021.
//

import XCTest
@testable import Countries

class CountriesTests: XCTestCase {
    
    var listVC: ListViewController!
    let indexPath = IndexPath(row: 0, section: 0)
    
    override func setUp() {
        listVC = ListViewController(networkManager: MockNetworkManager())
        listVC.loadViewIfNeeded()
    }
    
    func testContainSearchTextLowercase() throws {
        let searchText = "d"
        let string = "AnDorra"
        let result = string.containSearchText(searchText: searchText)
        XCTAssertTrue(result)
    }
    
    func testContainSearchTextEmptyLine() {
        let searchText = ""
        let string = "Andorra"
        let result = string.containSearchText(searchText: searchText)
        XCTAssertFalse(result)
    }
    
    func testFilterByNameUppercase() {
        let country = MockNetworkManager().getCountry()
        let result = [country].filterByName(searchText: "T")
        XCTAssertNotNil(result)
    }
    
    func testFilterByCapitalUppercase() {
        let country = MockNetworkManager().getCountry()
        let result = [country].filterByCapital(searchText: "T")
        XCTAssertNotNil(result)
    }
    
    func testFilterByContinentUppercase() {
        let country = MockNetworkManager().getCountry()
        let result = [country].filterByContinent(searchText: "TEST")
        XCTAssertNotNil(result)
    }
    
    func testFilterCountiesUppercase() {
        let country = MockNetworkManager().getCountry()
        let result = [country].filterCounties(searchText: "TEST")
        XCTAssertNotNil(result)
    }
    
    func testTableViewNumberOfRows() {
        let numberOfRowsResult = listVC.tableView.numberOfRows(inSection: 0)
        let filteredCountriesCount = listVC.filteredCountries.count
        XCTAssertEqual(numberOfRowsResult, filteredCountriesCount)
    }
    
    func testTableViewCellNotNil() {
        let cell = listVC.tableView(listVC.tableView, cellForRowAt: indexPath)
        XCTAssertNotNil(cell)
    }
    
    func testTableViewHeaderNotNill() {
        let header = listVC.tableView(listVC.tableView, viewForHeaderInSection: 0)
        XCTAssertNotNil(header)
    }

}

        
