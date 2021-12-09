
//
//  DetailsVCHeader.swift
//  Countries
//
//  Created by Khrystyna Matasova on 07.12.2021.
//

import Foundation
import UIKit


class DetailsVCHeader: UIView {
    
    private enum Constants {
        static let spacing: CGFloat = -60.0
        static let earthImage = UIImage(named: "earth")
        static let wingImage = UIImage(named: "wing")
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var earthView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.earthImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
   private let flagsView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.wingImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        self.addSubview(stackView)
        
        stackView.addArrangedSubview(earthView)
        stackView.addArrangedSubview(flagsView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
