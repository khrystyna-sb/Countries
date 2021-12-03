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
        static let earthImageName = "earth"
        static let labelText = "Choose a card :)"
        static let backgroundColor = UIColor(red: 0.945, green: 0.945, blue: 0.945, alpha: 1)
        static let fontSize: CGFloat = 44
    }
    
    static let identifier = "CountryTableViewHeader"
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
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
        label.font = .systemFont(ofSize: Constants.fontSize, weight: .medium)
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
        contentView.backgroundColor = Constants.backgroundColor
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(earthImageView)
        stackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
