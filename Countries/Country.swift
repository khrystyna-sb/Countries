//
//  Country.swift
//  Countries
//
//  Created by Khrystyna Matasova on 23.11.2021.
//

import Foundation

struct Country: Decodable {
//    var code: UUID
    var name: String
    var capital: String
    var continent: Continent
    var emoji: String
}

struct Continent: Decodable {
    var name: String
//    var countries: [Country]
}
