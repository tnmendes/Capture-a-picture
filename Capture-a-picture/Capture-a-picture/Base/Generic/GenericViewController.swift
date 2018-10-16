//
//  GenericViewController.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 15/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

import UIKit

public class GenericViewController<View: GenericView>: UIViewController {
    
    
    internal var contentView: View {
        return view as! View
    }
    
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    public required init?(coder: NSCoder){
        super.init(coder: coder)
    }
    
    
    public override func loadView() {
        self.navigationController?.setNavigationBarHidden(hideNavigationBar(), animated: false)
        view = View()
    }
    
    
    func hideNavigationBar() -> Bool {
        return true
    }
}
