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
            
            if response { //access granted
                
                DispatchQueue.main.async {

                    let vc = CameraViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                
                let alertController = UIAlertController(title: "Error", message: "This app need the access to Camera", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                })
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    
}
