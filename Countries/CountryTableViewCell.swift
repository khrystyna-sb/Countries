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
        static let indentContentsFromContainer: CGFloat = 15.0
        static let indentBetweenCells: CGFloat = 9.0
        static let spacing: CGFloat = 20
        static let gradientFirstColor = CGColor(red: 1, green: 228/255, blue: 133/255, alpha: 0.5)
        static let gradientSecondColor = CGColor(red: 186/255, green: 123/255, blue: 0, alpha: 0.5)
        static let cornerRadius: CGFloat = 15
        static let fontSize: CGFloat = 14
        static let notAvailable = "NA"
    }
    
    static let identifier = "CountryTableViewCell"
    
    override var frame: CGRect {
        didSet {
            gradient.frame = containerView.bounds
        }
    }
    
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        return label
    }()
    
    lazy private var capitalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        return label
    }()
    
    lazy private var regionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        return label
    }()
    
    let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            Constants.gradientFirstColor,
            Constants.gradientSecondColor
        ]
        gradient.locations = [0.22, 1]
        gradient.cornerRadius = Constants.cornerRadius
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
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.indentBetweenCells),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.indentContentsFromContainer),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.indentContentsFromContainer),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.indentBetweenCells),

            horisontalStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            horisontalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.indentContentsFromContainer),
            horisontalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.indentContentsFromContainer),
            horisontalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
        ])
    }
    
    public func configure(counrty: CountriesApiQuery.Data.Country) {
        nameLabel.text = "country\n" + counrty.name.uppercased()
        capitalLabel.text = "capital\n" + (counrty.capital?.uppercased() ?? Constants.notAvailable)
        regionLabel.text = "region\n" + counrty.continent.name.uppercased()
        flagImageView.image = UIImage(named: counrty.code.lowercased())
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        capitalLabel.text = nil
        flagImageView.image = nil
    }
}

