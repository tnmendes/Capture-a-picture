//
//  RoundedButton.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 18/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        initialize()
    }
    
    
    func initialize() {
        
        layer.cornerRadius =  frame.size.height / 4
        backgroundColor = UIColor.white
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.masksToBounds = false
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.5
        
        titleLabel?.textAlignment = .center
        setTitleColor(.black, for: .normal)
        
        contentEdgeInsets = UIEdgeInsetsMake(7,15,7,15)
    }
}
