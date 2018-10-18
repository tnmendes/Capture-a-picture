//
//  WellcomeView.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 15/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

import UIKit
import SnapKit


class WellcomeView: GenericView {
    
    private(set) var button = RoundedButton(type: UIButtonType.system)
    
    
    internal override func initializeUI() {
        
        addSubview(button)
        button.setTitle("Get started", for: .normal)
        self.backgroundColor = UIColor.white
    }
    
    
    internal override func createConstraints() {
        
        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
}
