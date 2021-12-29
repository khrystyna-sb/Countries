//
//  CountryMock.swift
//  CountriesTests
//
//  Created by Khrystyna Matasova on 21.12.2021.
//

import Foundation
import UIKit

class CountriesMock {
    var norway = TestCountry1()
    var ukraine = TestCountry2()
    
    func getCountries() -> [CountryMockProtocol] {
        return [norway, ukraine]
    }
}

protocol CountryMockProtocol {
    var name: String { get set }
    var capital: String { get set }
    var continent: String { get set }
}

class TestCountry1: CountryMockProtocol {
    var name = "Norway"
    var capital = "Oslo"
    var continent = "Europe"
}

class TestCountry2: CountryMockProtocol {
    var name = "Ukraine"
    var capital = "Kyiv"
    var continent = "Europe"
}
