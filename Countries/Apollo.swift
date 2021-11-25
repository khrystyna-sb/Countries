//
//  Apollo.swift
//  Countries
//
//  Created by Khrystyna Matasova on 24.11.2021.
//

import Foundation
import Apollo

class Apollo {
    
    static let shared = Apollo()
    
    let client: ApolloClient

    private init() {
        client = ApolloClient(url: URL(string: "https://countries.trevorblades.com/")!)
    }
}


