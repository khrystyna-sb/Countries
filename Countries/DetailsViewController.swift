
//
//  ViewController.swift
//  Countries
//
//  Created by Khrystyna Matasova on 19.11.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private enum Constants {
        static let indent: CGFloat = 38.0
        static let flagWidth: CGFloat = 127.0
        static let flagHeigth: CGFloat = 75.0
        static let backgroundColor = UIColor(red: 0.945, green: 0.945, blue: 0.945, alpha: 1)
        static let topAnchorConstant: CGFloat = 55.0
        static let leadingAnchorConstant: CGFloat = 34.0
        static let trailingAnchorConstant: CGFloat = 112.0
        static let bottomAnchorConstant: CGFloat = 58.0
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let defaultView: UIView = {
        let view = CountryTableViewHeader()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerView: DetailsVCHeader = {
        let view = DetailsVCHeader()
        view.contentMode = .scaleAspectFit
        
        if UIDevice.current.userInterfaceIdiom == .phone {
        view.backgroundColor = Constants.backgroundColor
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var country: CountriesApiQuery.Data.Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            defaultImage()
        }
     
        if country != nil {
            defaultView.isHidden = true
            createLabelsAndFlag()
            configureFlag()
            configureContents()
        }
    }
    
    private func defaultImage() {
        view.addSubview(defaultView)
        
        NSLayoutConstraint.activate([
            defaultView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.topAnchorConstant),
            defaultView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchorConstant),
            defaultView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.trailingAnchorConstant),
            defaultView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.bottomAnchorConstant)
        ])
    }
    
    private func configureFlag() {
        
        guard let country = country else { return }
        
        let layer = CALayer()
        layer.cornerRadius = 5
        flagImageView.layer.addSublayer(layer)
        
        let image = UIImage(named: country.code.lowercased())
        flagImageView.image = image
    }
    
    private func configureContents() {
  
        if UIDevice.current.userInterfaceIdiom == .pad {
            constraintsForIpad()
        } else {
            constraintsForIphone()
        }
    }
    
    private func constraintsForIpad() {
        view.addSubview(containerView)
        containerView.addSubview(headerView)
        containerView.addSubview(mainStackView)
        containerView.addSubview(flagImageView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.topAnchorConstant),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchorConstant),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.trailingAnchorConstant),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.bottomAnchorConstant),
            
            headerView.heightAnchor.constraint(equalToConstant: PublicConstants.heightForHeader),
            headerView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor),

            flagImageView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constants.indent),
            flagImageView.widthAnchor.constraint(equalToConstant: Constants.flagWidth),
            flagImageView.heightAnchor.constraint(equalToConstant: Constants.flagHeigth),
            flagImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.indent),
   
            
            mainStackView.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: Constants.indent),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.indent),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.indent),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    private func constraintsForIphone() {
        view.addSubview(headerView)
        view.addSubview(mainStackView)
        view.addSubview(flagImageView)
        
        NSLayoutConstraint.activate([
            
            headerView.heightAnchor.constraint(equalToConstant: PublicConstants.heightForHeader),
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -navigationItem.accessibilityFrame.size.height),
            
            flagImageView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constants.indent),
            flagImageView.widthAnchor.constraint(equalToConstant: Constants.flagWidth),
            flagImageView.heightAnchor.constraint(equalToConstant: Constants.flagHeigth),
            flagImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.indent),
            
            mainStackView.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: Constants.indent),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.indent),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.indent),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }

    
    private func createLabelsAndFlag() {
        
        guard let country = country else { return }
        
        var details: [String] = []
        
        let countryName = "Country\n" + country.name.uppercased()
        details.append(countryName)
        if let capital = country.capital {
            let capitalName = "Capital\n" + capital.uppercased()
            details.append(capitalName)
        }
        
        let continentName = "Region\n" + country.continent.name.uppercased()
        details.append(continentName)
        
        if let currency = country.currency {
            let currencyName = "Currency\n" + currency.uppercased()
            details.append(currencyName)
        }
        
        var languageNames = ""
        for (_, language) in country.languages.enumerated() {
            if let languageName = language.name {
                languageNames += languageName
                languageNames += " "
            }
        }
        if !languageNames.isEmpty {
            let languagesName = "Ofisial languages\n" + languageNames.uppercased()
            details.append(languagesName)
        }
        
        let callingCode = "Calling code\n" + country.phone.uppercased()
        details.append(callingCode)
        
        for i in 0..<details.count {
            let label = UILabel()
            label.text = details[i]
            label.textAlignment = .left
            label.numberOfLines = 2
            
            
            let horysontalStsckView = UIStackView()
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            
            if i % 2 == 0 {
                let image = UIImage(named: "ellipse1")
                imageView.image = image
            } else {
                let image = UIImage(named: "ellipse2")
                imageView.image = image
            }
            
            let vectorImage = UIImageView()
            vectorImage.image = UIImage(named: "vector")
            vectorImage.contentMode = .scaleAspectFit
            
            let verticalStackView = UIStackView()
            verticalStackView.axis = .vertical
            verticalStackView.alignment = .leading
            verticalStackView.distribution = .fillEqually
            verticalStackView.spacing = 10
            verticalStackView.addArrangedSubview(imageView)
            if i < details.count - 1 {
                verticalStackView.addArrangedSubview(vectorImage)
            } else {
                verticalStackView.addArrangedSubview(UIImageView())
            }
            
            horysontalStsckView.addArrangedSubview(verticalStackView)
            horysontalStsckView.addArrangedSubview(label)
            horysontalStsckView.spacing = 20
            horysontalStsckView.alignment = .top
            horysontalStsckView.distribution = .fillProportionally
            
            mainStackView.addArrangedSubview(horysontalStsckView)
        }
    }
}

