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
    
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        setInterfaceOrientations()

    }
    
    
    internal func hideNavigationBar() -> Bool {
        return true
    }
    
    
    internal func orientation() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    
    private func setInterfaceOrientations() {
    
        let restricRotation = (UIApplication.shared.delegate as! AppDelegate).restrictRotation
        let newOrientation = orientation()
        if(restricRotation == newOrientation){
            return //nothing to do here
        }
        
        (UIApplication.shared.delegate as! AppDelegate).restrictRotation = newOrientation
        let value = newOrientation.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    
    
    
    

}
