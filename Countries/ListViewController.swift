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
        countriesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
}
extension ListViewController {
    func loadData() {

        let query = CountriesApiQuery()
    
        Apollo.shared.client.fetch(query: query) { result in
 
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") else {return}
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
