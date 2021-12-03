//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Khrystyna Matasova on 26.11.2021.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let indent: CGFloat = 2.0
        static let indentMainFromCell: CGFloat = 15.0
        static let spacing: CGFloat = 20
        static let gradientFirstColor = CGColor(red: 1, green: 228/255, blue: 133/255, alpha: 0.5)
        static let gradientSecondColor = CGColor(red: 186/255, green: 123/255, blue: 0, alpha: 0.5)
    }
    
    static let identifier = "CountryTableViewCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let horisontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.spacing
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
            Constants.gradientFirstColor,
            Constants.gradientSecondColor
        ]
        gradient.locations = [0.22, 1]
        return gradient
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(containerView)
        setupContainerView()
        setupStackViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = containerView.bounds
    }
    
    private func setupContainerView() {
        containerView.layer.addSublayer(gradient)
        containerView.addSubview(horisontalStackView)
    }
    
    private func setupStackViews() {
        horisontalStackView.addArrangedSubview(flagImageView)
        horisontalStackView.addArrangedSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(capitalLabel)
        verticalStackView.addArrangedSubview(regionLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.indentMainFromCell),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.indentMainFromCell),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.indentMainFromCell),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.indentMainFromCell),
            
            horisontalStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            horisontalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            horisontalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            horisontalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
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
