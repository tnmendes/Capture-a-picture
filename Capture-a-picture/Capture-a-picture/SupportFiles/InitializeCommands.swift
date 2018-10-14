//
//  InitializeCommands.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 14/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

import UIKit


protocol Command {
    
    func execute()
}


struct InitialViewControllerCommand: Command {
    let keyWindow: UIWindow
    
    init(keyWindow: UIWindow) {
        self.keyWindow = keyWindow
    }
    
    
    func execute() {
        
        UIApplication.shared.isStatusBarHidden = true
        keyWindow.rootViewController = UINavigationController(rootViewController: WellcomeViewController())
        keyWindow.makeKeyAndVisible()
    }
}
