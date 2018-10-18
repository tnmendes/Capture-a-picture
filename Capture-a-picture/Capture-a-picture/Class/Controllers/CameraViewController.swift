//
//  CameraViewController.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 15/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

import UIKit

class CameraViewController: GenericViewController<CameraView> {
    
    private var cameraManager: CameraManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        self.cameraManager = CameraManager(delegate: self)
        self.cameraManager?.initialized()
        contentView.captureButton.addTarget(self, action: #selector(self.takePhotoTapped), for: .touchUpInside)
    }
    
    
    override func orientation() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeRight
    }
    
    
    override func viewDidLayoutSubviews() {
        self.cameraManager?.didLayout()
    }
    
    
    @objc func takePhotoTapped() {
        
        contentView.captureButton.isEnabled = false
        self.cameraManager?.takePhoto()
    }
    
    
    private func navigateToSelfie() -> SelfieViewController{
        
        let vc = SelfieViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        return vc
    }
}


extension CameraViewController: CameraManagerDelegate{
    
    
    func cameraPreviewView() -> UIView {
        
        return self.contentView.previewView
    }
    
    
    func cameraPhotoOut(capturedImage: UIImage?, error: Error?) {
        
        DispatchQueue.main.async {
            
            let network = NetworkManager()
            if let image = capturedImage {
                
                let vc = self.navigateToSelfie()
                vc.didUploadDocumentPhoto(state: true)
                network.performPostMultipartsOperation(image: image, filename: "document", completionHandler: { response in
                 
                    vc.didUploadDocumentPhoto(state: response)
                })
            }else{
                self.contentView.captureButton.isEnabled = true
            }
        }
    }
}
