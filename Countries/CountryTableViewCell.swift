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
        static let bossViewWidth: CGFloat = 388.0
        static let bossViewHeight: CGFloat = 179.0
        static let indentBossFromCell: CGFloat = 10.0
        static let imageHeight: CGFloat = TableConstants.heightForRow - indent
        static let imageWidth: CGFloat = imageHeight * 1.5
    }
    
    static let identifier = "CountryTableViewCell"
    
    private let bossView: UIView = {
        let bossView = UIView()
        bossView.translatesAutoresizingMaskIntoConstraints = false
        bossView.backgroundColor = UIColor(red: 214, green: 194, blue: 141, alpha: 0.5)
        return bossView
    }()
    
    private let horisontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let verticalStackView: UIStackView = {
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
        label.textAlignment = .left
        return label
    }()
    
    lazy private var capitalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    lazy private var regionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bossView)
//        contentView.addSubview(flagImageView)
//        contentView.addSubview(labelsStackView)
        fillInTheBossView()
        fillInTheStackViews()
        setupLayoutConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fillInTheBossView() {
        bossView.addSubview(horisontalStackView)
    }
    
    private func fillInTheStackViews() {
        horisontalStackView.addArrangedSubview(flagImageView)
        horisontalStackView.addArrangedSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(capitalLabel)
        verticalStackView.addArrangedSubview(regionLabel)
    }
    
    private func setupLayoutConstraints() {
//        let imageSideSize = contentView.frame.size.height - LayoutConstants.indent
        
        NSLayoutConstraint.activate([
            bossView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.indentBossFromCell),
            bossView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indentBossFromCell),
            bossView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutConstants.indentBossFromCell),
            bossView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.indentBossFromCell),
            
            horisontalStackView.topAnchor.constraint(equalTo: bossView.topAnchor),
            horisontalStackView.leadingAnchor.constraint(equalTo: bossView.leadingAnchor),
            horisontalStackView.trailingAnchor.constraint(equalTo: bossView.trailingAnchor),
            horisontalStackView.bottomAnchor.constraint(equalTo: bossView.bottomAnchor),
            
//            flagImageView.heightAnchor.constraint(equalToConstant: LayoutConstants.imageHeight),
//            flagImageView.widthAnchor.constraint(equalToConstant: LayoutConstants.imageWidth),
//            flagImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.indent),
//            flagImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            flagImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.indent),
//
//            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -imageSideSize),
//            verticalStackView.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor),
//            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
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
    
    
    
    
}
