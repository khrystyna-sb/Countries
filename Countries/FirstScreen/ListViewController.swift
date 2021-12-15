//
//  ListViewController.swift
//  Countries
//
//  Created by Khrystyna Matasova on 23.11.2021.
//

import UIKit

class ListViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    private enum Constants {
        static let heightForRow: CGFloat = 179.0
        static let notAplicableField = "NA"
        static let searchBarPlaceHolder = "Find Countries"
    }
    
    var countries: [CountriesApiQuery.Data.Country] = []
    var filteredCountries: [CountriesApiQuery.Data.Country] = []
    let tableRefreshControl = UIRefreshControl()

    let searchController: UISearchController = {
        let controller = UISearchController()
        controller.searchBar.searchBarStyle = .minimal
        controller.hidesNavigationBarDuringPresentation = false
        controller.searchBar.placeholder = Constants.searchBarPlaceHolder
        return controller
    }()

    @objc private func refresh(sender: UIRefreshControl) {
        self.searchController.searchBar.text = ""
        loadData(sender: sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        registerTableView()
        setupRefreshController()
        setupNavigationItem()
        setUpSearchController()
        loadData()
    }
    
    func setupRefreshController() {
        tableView.refreshControl = tableRefreshControl
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(sender: )), for: .valueChanged)
    }
    
    func setupNavigationItem() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        self.navigationItem.title = "Country list"
    }

    func setUpSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }

    private func registerTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier)
        tableView.register(CountryTableViewHeader.self, forHeaderFooterViewReuseIdentifier: CountryTableViewHeader.identifier)
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell else {return UITableViewCell()}
        let country = filteredCountries[indexPath.row]
        cell.configure(counrty: country)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let country = filteredCountries[indexPath.row]
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

    func filterContentForSearchText(searchText: String) {
        filteredCountries = countries.filter({
            $0.continent.name.lowercased().contains(searchText.lowercased()) ||
            ($0.capital ?? Constants.notAplicableField).lowercased().contains(searchText.lowercased()) ||
            $0.name.lowercased().contains(searchText.lowercased())
        })
        //  TODO change filter condition
        if isSearchBarEmpty() { filteredCountries = countries }
        tableView.reloadData()
    }

    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text ?? "")
    }

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text ?? "")
    }
}

extension ListViewController {
    func loadData(sender: UIRefreshControl? = nil) {
        let query = CountriesApiQuery()
        guard let client = Apollo.shared.client else { return }
        client.fetch(query: query) { result in
            
            switch result {
            case .success(let graphQLResult):
                if let countries = graphQLResult.data?.countries.compactMap({ $0 }) {
                    self.countries = countries
                    self.filteredCountries = countries
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                
                print("Error loading data \(error)")
            }
        }
        sender?.endRefreshing()
    }
}
