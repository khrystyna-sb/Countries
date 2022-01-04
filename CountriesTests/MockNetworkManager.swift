//
//  MockNetworkManager.swift
//  Countries
//
//  Created by Khrystyna Matasova on 04.01.2022.
//

import Apollo
import Foundation

class MockNetworkManager: NetworkManagerProtocol {
    
    func getCountry() -> CountriesApiQuery.Data.Country {
        let continent = CountriesApiQuery.Data.Country.Continent(name: "testcontinent")
        let language = CountriesApiQuery.Data.Country.Language(name: "testlanguage")
        return CountriesApiQuery.Data.Country(code: "UA", name: "testname", capital: "testcapital", currency: "testcurrency", phone: "testphone", continent: continent, languages: [language])
    }
    
    func getCountries(completion: @escaping (Result<[CountriesApiQuery.Data.Country]?, Error>) -> Void) {
        completion(Result.success([getCountry(), getCountry()]))
    }
}
