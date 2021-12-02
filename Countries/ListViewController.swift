//
//  ListViewController.swift
//  Countries
//
//  Created by Khrystyna Matasova on 23.11.2021.
//

import UIKit
//
enum TableConstants {
    static let heightForRow: CGFloat = 179.0
}

class ListViewController: UITableViewController {
    
    var countries: [CountriesApiQuery.Data.Country] = []
    
    let headerView: UIImageView = {
        var headerView = UIImageView()
        let image = UIImage(named: "headerList")
        headerView.image = image
        headerView.contentMode = .scaleAspectFill
        return headerView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Countries"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        registerTableView()
        loadData()
    }
    
    private func registerTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier )
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        1
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell else {return UITableViewCell()}
        let country = countries[indexPath.row]
        cell.configure(counrty: country)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let country = countries[indexPath.row]
        let detailsVC = DetailsViewController()
        detailsVC.country = country
        
        showDetailViewController(UINavigationController(rootViewController: detailsVC), sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableConstants.heightForRow
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UITableViewHeaderFooterView()
        header.addSubview(headerView)
        return header
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
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                
                print("Error loading data \(error)")
            }
        }
    }
}
