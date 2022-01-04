//
//  NetworkManager.swift
//  Countries
//
//  Created by Khrystyna Matasova on 28.12.2021.
//

import Foundation

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

