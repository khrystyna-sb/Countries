//
//  ViewController.swift
//  Countries
//
//  Created by Khrystyna Matasova on 19.11.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var countryName = ""
    var countryCapital = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.width / 2
        let height = view.frame.width / 8
        let x = view.bounds.width/2 - width/2
        let y = view.bounds.height/2 - height/2
      
        
        let label = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        label.text = countryName
        label.textAlignment = .center
        label.numberOfLines = 2
        
        view.addSubview(label)
    }
    
    
   
    
    
}

