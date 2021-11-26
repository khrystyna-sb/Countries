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
    }
    
    static let identifier = "CountryTableViewCell"
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let capitalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let regionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(flagImageView)
        contentView.addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(nameText: String, capitalText: String?, regionText: String, imageName: String) {
        nameLabel.text = nameText
        capitalLabel.text = capitalText
        regionLabel.text = regionText
        flagImageView.image = UIImage(named: imageName)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        capitalLabel.text = nil
        flagImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSideSize = contentView.frame.size.height - LayoutConstants.indent
        let stackWightSize = contentView.frame.width - imageSideSize
        let stackHeightSize = contentView.frame.height
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(capitalLabel)
        stackView.addArrangedSubview(regionLabel)
        // how to not copie paste the same code?
    
        stackView.frame = CGRect(x: imageSideSize, y: 0, width: stackWightSize, height: stackHeightSize)
        flagImageView.frame = CGRect(x: 1, y: 1, width: imageSideSize, height: imageSideSize )
    }
}
