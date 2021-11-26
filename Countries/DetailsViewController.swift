//
//  ViewController.swift
//  Countries
//
//  Created by Khrystyna Matasova on 19.11.2021.
//

import UIKit



class DetailsViewController: UIViewController {
    
    //    private enum LayoutConstants {
    //
    //    }
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var countryName = ""
    var countryCapital = ""
    var countryContinent = ""
    var countryCurrency = ""
    var countryLanguages = ""
    var countryPhoneCode = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let details = [countryName, countryCapital, countryContinent, countryCurrency, countryLanguages, countryPhoneCode]
        
        var labels: [UILabel] = []
        for i in 0..<details.count {
            let label = UILabel()
            label.text = details[i]
            label.textAlignment = .center
            label.numberOfLines = 2
            labels.append(label)
            stackView.addArrangedSubview(label)
        }
        
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
    
    
    
    
}

