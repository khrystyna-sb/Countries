//
//  ViewController.swift
//  Countries
//
//  Created by Khrystyna Matasova on 19.11.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var country: CountriesApiQuery.Data.Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createLabelsAndFlag()
        setupStackView()
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -navigationItem.accessibilityFrame.size.height),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createLabelsAndFlag() {
        guard let country = country else { return }
        
        let flagImageView = UIImageView(image: UIImage(named: country.code.lowercased()))
        flagImageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(flagImageView)
        var details: [String] = []
        
        details.append(country.name)
        if let capital = country.capital {
            details.append(capital)
        }
        
        details.append(country.continent.name)
        
        if let currency = country.currency {
            details.append(currency)
        }
        
        var languageNames = ""
        for (_, language) in country.languages.enumerated() {
            if let languageName = language.name {
                languageNames += languageName
                languageNames += " "
            }
        }
        print(languageNames.isEmpty)
        if !languageNames.isEmpty {
            details.append(languageNames)
        }
        
        details.append(country.phone)
        
        var labels: [UILabel] = []
        for i in 0..<details.count {
            let label = UILabel()
            label.text = details[i]
            
            label.textAlignment = .center
            label.numberOfLines = 2
            labels.append(label)
            stackView.addArrangedSubview(label)
        }
    }
}


