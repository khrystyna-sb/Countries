//
//  CountriesTests.swift
//  CountriesTests
//
//  Created by Khrystyna Matasova on 19.11.2021.
//

import XCTest
@testable import Countries

class CountriesTests: XCTestCase {
    
//    var listVC: ListViewController?
    
    func getCountry() -> CountriesApiQuery.Data.Country {
        let continent = CountriesApiQuery.Data.Country.Continent(name: "testcontinent")
        let language = CountriesApiQuery.Data.Country.Language(name: "testlanguage")
        return CountriesApiQuery.Data.Country(code: "testcode", name: "testname", capital: "testcapital", currency: "testcurrency", phone: "testphone", continent: continent, languages: [language])
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
        let country = getCountry()
        let result = [country].filterByName(searchText: "T")
        XCTAssertNotNil(result)
    }
    
    func testFilterByCapitalUppercase() {
        let country = getCountry()
        let result = [country].filterByCapital(searchText: "T")
        XCTAssertNotNil(result)
    }
    
    func testFilterByContinentUppercase() {
        let country = getCountry()
        let result = [country].filterByContinent(searchText: "TEST")
        XCTAssertNotNil(result)
    }
    
    func testFilterCountiesUppercase() {
        let country = getCountry()
        let result = [country].filterCounties(searchText: "TEST")
        XCTAssertNotNil(result)
    }
    
//    override class func setUp() {
//        super.setUp()
//        self.listVC = ListViewController()
//        listVC.loadView()
//        listVC.viewDidLoad()
//    }
    
    func testTableViewNumberOfRows() {
        let listVC = ListViewController(networkManager: MockNetworkManager())
        let numberOfRowsResult = listVC.tableView.numberOfRows(inSection: 0)
        let filteredCountriesCount = listVC.filteredCountries.count
        XCTAssertEqual(numberOfRowsResult, filteredCountriesCount)
    }
    
    func testTableViewCellNotNil() throws {
        let listVC = ListViewController(networkManager: MockNetworkManager())
        listVC.loadView()
        listVC.viewDidLoad()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = listVC.tableView.cellForRow(at: indexPath)
   //     let cell = listVC.tableView.dataSource?.tableView(listVC.tableView, cellForRowAt: indexPath)
        XCTAssertNotNil(cell)
    }
    
//    func testTableViewCellCurrentType() {
//        let listVC = ListViewController()
//        listVC.tableView.dataSource(
//        let testCell = CountryTableViewCell()
//
//    }
}

        
