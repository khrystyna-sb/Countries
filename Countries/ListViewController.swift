//
//  ListViewController.swift
//  Countries
//
//  Created by Khrystyna Matasova on 23.11.2021.
//

import UIKit

class ListViewController: UIViewController {
    
    let countriesTableView = UITableView()
    var countries: [CountriesApiQuery.Data.Country] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }
    
    private func setupTableView() {
        view.addSubview(countriesTableView)
        countriesTableView.frame = view.bounds
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        countriesTableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier )
    }
    
}
extension ListViewController {
    func loadData() {
        
        let query = CountriesApiQuery()
        guard let client = Apollo.shared.client else {return}
        client.fetch(query: query) { result in
            
            switch result {
            case .success(let graphQLResult):
                if let countries = graphQLResult.data?.countries.compactMap({ $0 }) {
                    // 4
                    self.countries = countries
                    self.countriesTableView.reloadData()
                }
                
            case .failure(let error):
                
                print("Error loading data \(error)")
            }
        }
    }
}


extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell else {return UITableViewCell()}
        let text = countries[indexPath.row].name
        let image = countries[indexPath.row].code.lowercased()
        cell.configure(text: text, imageName: image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {return}
        detailsVC.countryName = "Country - \(countries[indexPath.row].name)"
        guard let countryCapital = countries[indexPath.row].capital else {return}
        detailsVC.countryCapital = "Capital - \(countryCapital)"
        detailsVC.countryContinent = "Region - \(countries[indexPath.row].continent.name)"
        guard let countryCurrency = countries[indexPath.row].currency else {return}
        detailsVC.countryCurrency = "Currency - \(countryCurrency)"
        guard let countryLanguages = countries[indexPath.row].languages[0].name else {return}
        detailsVC.countryLanguages = "Language - \(countryLanguages)"
        detailsVC.countryPhoneCode = "Phone code - \(countries[indexPath.row].phone)"
        
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
