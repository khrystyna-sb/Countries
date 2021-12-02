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
        static let indentBossFromCell: CGFloat = 15.0
        static let spacing: CGFloat = 20
    }
    
    private enum ColorConstants {
        static let gradientFirstColor = CGColor(red: 1, green: 228/255, blue: 133/255, alpha: 0.5)
        static let gradientSecondColor = CGColor(red: 186/255, green: 123/255, blue: 0, alpha: 0.5)
    }
    
    static let identifier = "CountryTableViewCell"
    
    private let bossView: UIView = {
        let bossView = UIView()
        bossView.translatesAutoresizingMaskIntoConstraints = false
        return bossView
    }()
    
    private let horisontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = LayoutConstants.spacing
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
    
    let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            ColorConstants.gradientFirstColor,
            ColorConstants.gradientSecondColor
        ]
        gradient.locations = [0.22, 1]
        return gradient
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bossView)
        fillInTheBossView()
        fillInTheStackViews()
        setupLayoutConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bossView.bounds
    }
    
    private func fillInTheBossView() {
        bossView.layer.addSublayer(gradient)
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
        
        NSLayoutConstraint.activate([
            bossView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.indentBossFromCell),
            bossView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indentBossFromCell),
            bossView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutConstants.indentBossFromCell),
            bossView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.indentBossFromCell),
            
            horisontalStackView.topAnchor.constraint(equalTo: bossView.topAnchor),
            horisontalStackView.leadingAnchor.constraint(equalTo: bossView.leadingAnchor),
            horisontalStackView.trailingAnchor.constraint(equalTo: bossView.trailingAnchor),
            horisontalStackView.bottomAnchor.constraint(equalTo: bossView.bottomAnchor),
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
