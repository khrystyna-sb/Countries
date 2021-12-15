//
//  ListViewController.swift
//  Countries
//
//  Created by Khrystyna Matasova on 23.11.2021.
//

import UIKit

class ListViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {

    enum Scopes: Int, CaseIterable {
        case all
        case names
        case capitals
        case continents
        var title: String {
            switch self {
            case .all:
                return "All"
            case .names:
                return "Names"
            case .capitals:
                return "Capitals"
            case .continents:
                return "Continents"
            }
        }
        static var titles: [String] {
            self.allCases.map({ $0.title })
        }
    }
    
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
        controller.searchBar.scopeButtonTitles = Scopes.titles
        controller.searchBar.setShowsCancelButton(false, animated: false)
        return controller
    }()

    @objc private func refresh(sender: UIRefreshControl) {
        searchController.searchBar.text = ""
        searchController.searchBar.endEditing(true)
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
        searchController.searchBar.tintColor = .black
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

    func filterContentForSearchText(searchText: String,
                                    scopeIndex: Scopes = .all) {
        filteredCountries = countries.filter({ (country: CountriesApiQuery.Data.Country) -> Bool in
            var doesCategoryMatch: Bool = isSearchBarEmpty()
            switch scopeIndex {
            case .names:
                doesCategoryMatch = doesCategoryMatch ||
                country.name.lowercased().contains(searchText.lowercased())
            case .capitals:
                doesCategoryMatch = doesCategoryMatch ||
                (country.capital ?? Constants.notAplicableField).lowercased().contains(searchText.lowercased())
            case .continents:
                doesCategoryMatch = doesCategoryMatch ||
                country.continent.name.lowercased().contains(searchText.lowercased())
            case .all:
                doesCategoryMatch = doesCategoryMatch ||
                country.name.lowercased().contains(searchText.lowercased()) ||
                (country.capital ?? Constants.notAplicableField).lowercased().contains(searchText.lowercased()) ||
                country.continent.name.lowercased().contains(searchText.lowercased())
            }
            return doesCategoryMatch
        })
        tableView.reloadData()
    }

    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if let scopeIndex = Scopes(rawValue: searchBar.selectedScopeButtonIndex) {
            filterContentForSearchText(searchText: searchController.searchBar.text ?? "",
                                       scopeIndex: scopeIndex)
        }
    }

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if let scopeIndex = Scopes(rawValue: searchBar.selectedScopeButtonIndex) {
            filterContentForSearchText(searchText: searchBar.text ?? "",
                                       scopeIndex: scopeIndex)
        }
        filterContentForSearchText(searchText: searchController.searchBar.text ?? "")
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
