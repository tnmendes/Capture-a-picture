//
//  FinishView.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 18/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

import UIKit
import SnapKit


class FinishView: GenericView {
    
    private(set) var button = RoundedButton(type: UIButtonType.system)
    private(set) var label = UILabel()
    
    internal override func initializeUI() {
        
        self.backgroundColor = UIColor.white
        addSubview(button)
        button.setTitle("Start over", for: .normal)
        addSubview(label)
        label.text = "Thank you"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
    }
    
    
    internal override func createConstraints() {
        
        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.bottom.equalTo(self.button.snp.top).offset(-15)
            make.leading.trailing.equalToSuperview()
        }
    }
    
}
