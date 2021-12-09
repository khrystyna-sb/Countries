//
//  ListViewController.swift
//  Countries
//
//  Created by Khrystyna Matasova on 23.11.2021.
//

import UIKit

class ListViewController: UITableViewController {
    
    private enum Constants {
        static let heightForRow: CGFloat = 179.0
    }
    
    var countries: [CountriesApiQuery.Data.Country] = []
    
//    var navigationBarTitleView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(red: 0.839, green: 0.761, blue: 0.553, alpha: 0.5)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationItem()
        registerTableView()
        loadData()
    }
    
    func setupNavigationItem() {
        self.navigationItem.title = "Country list"
//        navigationController?.navigationBar.barTintColor = UIColor.green
//        self.navigationItem.titleView = navigationBarTitleView
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func registerTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier)
        tableView.register(CountryTableViewHeader.self, forHeaderFooterViewReuseIdentifier: CountryTableViewHeader.identifier)
        tableView.separatorStyle = .none
    }
    
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
        return Constants.heightForRow
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CountryTableViewHeader.identifier) as? CountryTableViewHeader else { return nil }
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (UIDevice.current.userInterfaceIdiom == .phone) ? PublicConstants.heightForHeader : 0
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
