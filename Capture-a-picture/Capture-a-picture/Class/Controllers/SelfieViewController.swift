//
//  SelfieViewController.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 18/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

import UIKit

class SelfieViewController: GenericViewController<CameraView> {
    
    var cameraManager: CameraManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cameraManager = CameraManager(delegate: self)
        self.cameraManager?.initialized()
        contentView.captureButton.addTarget(self, action: #selector(self.takePhotoTapped), for: .touchUpInside)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.showAlertMessage(title: "Take a selfie", message: "This is the Last step")
    }
    
    override func viewDidLayoutSubviews() {
        
        self.cameraManager?.didLayout()
    }
    
    
    @objc func takePhotoTapped() {
        
        contentView.captureButton.isEnabled = false
        self.cameraManager?.takePhoto()
    }
    
    
    func navigateToFinish() {
        
        let vc = FinishViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension SelfieViewController: CameraManagerDelegate{
    
    
    func cameraPreviewView() -> UIView {
        
        return self.contentView.previewView
    }
    
    
    func cameraPhotoOut(capturedImage: UIImage?, error: Error?) {
        
        let network = NetworkManager()
        if let image = capturedImage {
            
            network.performPostMultipartsOperation(image: image, completionHandler: { response in
                
                if(response){
                    print("Done")
                    self.navigateToFinish()
                }else{
                    
                    DispatchQueue.main.async {
                        self.contentView.captureButton.isEnabled = true
                        self.showAlertError(message: "Please take another photo")
                    }
                }
            })
        }
    }
}
