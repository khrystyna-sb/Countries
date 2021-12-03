//
//  ListHeader.swift
//  Countries
//
//  Created by Khrystyna Matasova on 02.12.2021.
//

import Foundation
import UIKit


class CountryTableViewHeader: UITableViewHeaderFooterView {
    
    private enum HeaderConstants {
        static let spacing: CGFloat = 20
        static let stackViewIndent: CGFloat = 40
    }
    
    static let identifier = "CountryTableViewHeader"
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = HeaderConstants.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let earthImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
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
        contentView.addSubview(mainImageView)
        mainImageView.addSubview(stackView)
        stackView.addArrangedSubview(earthImageView)
        stackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            mainImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: HeaderConstants.stackViewIndent),
            stackView.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: -HeaderConstants.stackViewIndent)
        ])
    }
}
