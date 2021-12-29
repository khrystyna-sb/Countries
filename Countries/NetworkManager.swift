//
//  NetworkManager.swift
//  Countries
//
//  Created by Khrystyna Matasova on 28.12.2021.
//

import Foundation

protocol NetworkManagerProtocol {
    func getCountries(countries: @escaping ([CountriesApiQuery.Data.Country]?) -> Void)
    func getCountriesMock(countries: @escaping ([CountryMockProtocol]?) -> Void)
}

extension NetworkManagerProtocol {
    func getCountries(countries: @escaping ([CountriesApiQuery.Data.Country]?) -> Void) {}
    func getCountriesMock(countries: @escaping ([CountryMockProtocol]?) -> Void) {}
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
    func getCountriesMock(countries: @escaping ([CountryMockProtocol]?) -> Void) {
        let counrties = CountriesMock().getCountries()
        countries(counrties)
    }
}

