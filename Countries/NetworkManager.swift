//
//  NetworkManager.swift
//  Countries
//
//  Created by Khrystyna Matasova on 28.12.2021.
//

import Foundation

protocol NetworkManagerProtocol {
    func getCountries(completion: @escaping (Result<[CountriesApiQuery.Data.Country]?, Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    func getCountries(completion: @escaping (Result<[CountriesApiQuery.Data.Country]?, Error>) -> Void)  {
        let query = CountriesApiQuery()
        guard let client = Apollo.shared.client else { return }
        client.fetch(query: query) { result in
            
            switch result {
            case .success(let graphQLResult):
                if let data = graphQLResult.data {
                    completion(Result.success(data.countries))
                }
            case .failure(let error):
                completion(Result.failure(error))
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
    
    func getCountries(completion: @escaping (Result<[CountriesApiQuery.Data.Country]?, Error>) -> Void) {
        completion(Result.success([getCountry(), getCountry()]))
    }
}

