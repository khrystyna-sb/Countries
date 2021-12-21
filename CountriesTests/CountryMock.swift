//
//  CountryMock.swift
//  CountriesTests
//
//  Created by Khrystyna Matasova on 21.12.2021.
//

import Foundation
import UIKit

class CountriesMock {
    var norway = Norway()
    var ukraine = Ukraine()
    
    func getCountries() -> [CountryMock] {
        return [norway, ukraine]
    }
}

protocol CountryMock {
    var name: String { get set }
    var capital: String { get set }
    var continent: String { get set }
}

class Norway: CountryMock {
    var name = "Norway"
    var capital = "Oslo"
    var continent = "Europe"
}

class Ukraine: CountryMock {
    var name = "Ukraine"
    var capital = "Kyiv"
    var continent = "Europe"
}


extension Array where Element == [CountryMock]  {
    typealias Country = [CountryMock]
    private struct Constants {
        static let notApplicableField: String = "N-A"
    }

    func filterByName(searchText: String) -> [Country] {
        return filter { $0.name.containSearchText(searchText: searchText) }
    }
    func filterByCapital(searchText: String) -> [Country] {
        return filter { ($0.capital ?? Constants.notApplicableField).containSearchText(searchText: searchText) }
    }
    func filterByContinent(searchText: String) -> [Country] {
        return filter { $0.continent.name.containSearchText(searchText: searchText) }
    }
//    func filterCounties(searchText: String) -> [Country] {
//        return filter {
//            $0.name.containSearchText(searchText: searchText) ||
//            ($0.capital ?? Constants.notApplicableField).containSearchText(searchText: searchText) ||
//            $0.continent.name.containSearchText(searchText: searchText)
//        }
//    }
}

