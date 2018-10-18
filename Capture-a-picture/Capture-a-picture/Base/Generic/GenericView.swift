//
//  GenericView.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 15/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

import UIKit

public class GenericView: UIView {
    
    
    public required init() {
        
        super.init(frame: CGRect.zero)
        initializeUI()
        createConstraints()
    }
    
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        initializeUI()
        createConstraints()
    }
    
    internal func initializeUI() {}
    
    internal func createConstraints() {}
    
}
