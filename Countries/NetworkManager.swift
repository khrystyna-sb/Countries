//
//  NetworkManager.swift
//  Countries
//
//  Created by Khrystyna Matasova on 28.12.2021.
//

import Foundation

protocol NetworkManagerProtocol {
    func getCountries(countries: @escaping ([CountriesApiQuery.Data.Country]?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {

    func getCountries(countries: @escaping ([CountriesApiQuery.Data.Country]?) -> Void)  {
        let query = CountriesApiQuery()
        guard let client = Apollo.shared.client else { return }
        client.fetch(query: query) { result in
            
            switch result {
            case .success(let graphQLResult):
                countries(graphQLResult.data?.countries)
            case .failure(let error):
                print("Error loading data \(error)")
            }
        }
    }
}

class MockNetworkManager: NetworkManagerProtocol {
    func getCountry() -> CountriesApiQuery.Data.Country {
        let continent = CountriesApiQuery.Data.Country.Continent(name: "testcontinent")
        let language = CountriesApiQuery.Data.Country.Language(name: "testlanguage")
        return CountriesApiQuery.Data.Country(code: "UA", name: "testname", capital: "testcapital", currency: "testcurrency", phone: "testphone", continent: continent, languages: [language])
    }
    
    func getCountries(countries: @escaping ([CountriesApiQuery.Data.Country]?) -> Void)  {
        countries([getCountry(), getCountry()])
    }
}

