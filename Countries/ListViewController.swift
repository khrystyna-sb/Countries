//
//  ListViewController.swift
//  Countries
//
//  Created by Khrystyna Matasova on 23.11.2021.
//

import UIKit
//
enum TableConstants {
    static let heightForRow: CGFloat = 100.0
}

class ListViewController: UIViewController {
    
    let countriesTableView = UITableView()
    var countries: [CountriesApiQuery.Data.Country] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Countries"
        self.navigationController?.navigationBar.prefersLargeTitles = true
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

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell else {return UITableViewCell()}
        let country = countries[indexPath.row]
        cell.configure(counrty: country)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let country = countries[indexPath.row]
        guard let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {return}
        detailsVC.country = country
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableConstants.heightForRow
    }
}


extension ListViewController {
    func loadData() {
        
        let query = CountriesApiQuery()
        guard let client = Apollo.shared.client else { return }
        client.fetch(query: query) { result in
            
            switch result {
            case .success(let graphQLResult):
                if let countries = graphQLResult.data?.countries.compactMap({ $0 }) {
                    self.countries = countries
                    self.countriesTableView.reloadData()
                }
                
            case .failure(let error):
                
                print("Error loading data \(error)")
            }
        }
    }
}
