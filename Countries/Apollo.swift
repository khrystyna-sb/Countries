//
//  Apollo.swift
//  Countries
//
//  Created by Khrystyna Matasova on 24.11.2021.
//

import Apollo
import Foundation

class Apollo {
    
    static let shared = Apollo()
    
    var client: ApolloClient?
    
    private init() {
        if let url = URL(string: "https://countries.trevorblades.com/") {
            client = ApolloClient(url: url)
        }
    }
}
