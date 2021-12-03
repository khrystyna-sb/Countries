//
//  ListHeader.swift
//  Countries
//
//  Created by Khrystyna Matasova on 02.12.2021.
//

import Foundation
import UIKit

class CountryTableViewHeader: UITableViewHeaderFooterView {
    
    private enum Constants {
        static let spacing: CGFloat = 0
        static let stackViewIndent: CGFloat = 0
        static let earthImageName = "earth"
        static let labelText = "Choose a card :)"
    }
    
    static let identifier = "CountryTableViewHeader"
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let earthImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.earthImageName)
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = Constants.labelText
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(earthImageView)
        stackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: Constants.stackViewIndent),
            stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -Constants.stackViewIndent)
        ])
    }
}
