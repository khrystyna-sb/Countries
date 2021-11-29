//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Khrystyna Matasova on 26.11.2021.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    private enum LayoutConstants {
        static let indent: CGFloat = 2.0
        static let imageHeight: CGFloat = TableConstants.heightForRow - indent
        static let imageWidth: CGFloat = imageHeight * 1.5
    }
    
    static let identifier = "CountryTableViewCell"
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy private var capitalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy private var regionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(flagImageView)
        contentView.addSubview(stackView)
        
        setupStackView()
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(capitalLabel)
        stackView.addArrangedSubview(regionLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(counrty: CountriesApiQuery.Data.Country) {
        nameLabel.text = counrty.name
        capitalLabel.text = counrty.capital
        regionLabel.text = counrty.continent.name
        flagImageView.image = UIImage(named: counrty.code.lowercased())
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        capitalLabel.text = nil
        flagImageView.image = nil
    }
    
    private func setupStackView() {
        let imageSideSize = contentView.frame.size.height - LayoutConstants.indent
        
        NSLayoutConstraint.activate([
            
            flagImageView.heightAnchor.constraint(equalToConstant: LayoutConstants.imageHeight),
            flagImageView.widthAnchor.constraint(equalToConstant: LayoutConstants.imageWidth),
            flagImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.indent),
            flagImageView.trailingAnchor.constraint(equalTo: stackView.leadingAnchor),
            flagImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            flagImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.indent),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -imageSideSize),
            stackView.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
