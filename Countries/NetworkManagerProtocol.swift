//
//  NetworkManagerProtocol.swift
//  CountriesTests
//
//  Created by Khrystyna Matasova on 04.01.2022.
//
import Apollo
import Foundation

protocol NetworkManagerProtocol {
    func getCountries(completion: @escaping (Result<[CountriesApiQuery.Data.Country]?, Error>) -> Void)
}
