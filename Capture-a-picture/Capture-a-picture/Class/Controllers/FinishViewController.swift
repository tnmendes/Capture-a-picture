//
//  FinishViewController.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 16/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

import Foundation
import UIKit

class FinishViewController: GenericViewController<FinishView> {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.button.addTarget(self, action: #selector(self.starAgain), for: .touchUpInside)
    }
    
    
    @objc func starAgain() {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}
