//
//  ListViewController.swift
//  Countries
//
//  Created by Khrystyna Matasova on 23.11.2021.
//

import UIKit

class ListViewController: UIViewController {

    let countriesTableView = UITableView()
    let countryGenerator = CountryGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(countriesTableView)
        countriesTableView.frame = view.bounds
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        countriesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = countryGenerator.country1.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsVC = DetailsViewController()
        let splitVC  = storyboard?.instantiateViewController(withIdentifier: "SplitViewController")
        splitVC?.present(detailsVC, animated: true, completion: nil)
        
//        navigationController?.pushViewController(detailsVC, animated: true)
   //     print("selected row is \(indexPath.row)")
    }
    
}
