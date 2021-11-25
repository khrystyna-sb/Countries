//
//  ViewController.swift
//  Countries
//
//  Created by Khrystyna Matasova on 19.11.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
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
        }
        
        
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.frame = view.bounds
        stackView.backgroundColor = .systemYellow
        stackView.axis = .vertical
        
        view.addSubview(stackView)
    }
    
    
    
    
    
}

