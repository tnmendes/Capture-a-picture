//
//  WellcomeViewController.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 14/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

import UIKit
import AVFoundation

class WellcomeViewController: GenericViewController<WellcomeView> {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.button.addTarget(self, action: #selector(self.startTapped), for: .touchUpInside)
    }
    
    
    @objc func startTapped() {
        
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            
            DispatchQueue.main.async {
                
                if response { //access granted
                    
                    let vc = CameraViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    
                    self.showAlertError(message: "This app need the access to Camera")
                }
            }
        }
    }
    
}
