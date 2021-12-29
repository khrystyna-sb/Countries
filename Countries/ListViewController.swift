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
        static let searchBarPlaceHolder = "Find Countries"
    }
    
    var countries = [CountriesApiQuery.Data.Country]()
    var filteredCountries: [CountriesApiQuery.Data.Country] = []
    var networkManager: NetworkManagerProtocol 
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
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        searchController.searchBar.text = ""
        searchController.searchBar.endEditing(true)
        getData(sender: sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        registerTableView()
        setupRefreshController()
        setupNavigationItem()
        setUpSearchController()
        getData()
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

    func registerTableView() {
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
        if isSearchBarEmpty() { return }
        switch scopeIndex {
        case .all:
            filteredCountries = countries.filterCounties(searchText: searchText)
        case .names:
            filteredCountries = countries.filterByName(searchText: searchText)
        case .capitals:
            filteredCountries = countries.filterByCapital(searchText: searchText)
        case .continents:
            filteredCountries = countries.filterByContinent(searchText: searchText)
        }
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
    func getData(sender: UIRefreshControl? = nil) {
        networkManager.getCountries(countries: { countries in
            guard let countries = countries else { return }
            self.countries = countries
            self.filteredCountries = countries
            self.tableView.reloadData()
        })
        sender?.endRefreshing()
    }
}

extension String {
    func containSearchText(searchText: String) -> Bool {
        return lowercased().contains(searchText.lowercased())
    }
}

extension Array where Element == CountriesApiQuery.Data.Country {
    typealias Country = CountriesApiQuery.Data.Country
    private struct Constants {
        static let notApplicableField: String = "N-A"
    }

    func filterByName(searchText: String) -> [Country] {
        return filter { $0.name.containSearchText(searchText: searchText) }
    }
    func filterByCapital(searchText: String) -> [Country] {
        return filter { ($0.capital ?? Constants.notApplicableField).containSearchText(searchText: searchText) }
    }
    func filterByContinent(searchText: String) -> [Country] {
        return filter { $0.continent.name.containSearchText(searchText: searchText) }
    }
    func filterCounties(searchText: String) -> [Country] {
        return filter {
            $0.name.containSearchText(searchText: searchText) ||
            ($0.capital ?? Constants.notApplicableField).containSearchText(searchText: searchText) ||
            $0.continent.name.containSearchText(searchText: searchText)
        }
    }
}
