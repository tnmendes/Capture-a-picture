//
//  StartupCommandsBuilder.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 14/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

import UIKit

final class StartupCommandsBuilder {
    private var window: UIWindow!
    
    func setKeyWindow(_ window: UIWindow) -> StartupCommandsBuilder {
        self.window = window
        return self
    }
    
    
    func build() -> [Command] {
        return [
            InitialViewControllerCommand(keyWindow: window)
        ]
    }
    
}
