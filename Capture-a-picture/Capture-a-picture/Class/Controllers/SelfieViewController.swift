//
//  SelfieViewController.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 18/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

import UIKit

class SelfieViewController: GenericViewController<CameraView> {
    
    private var cameraManager: CameraManager?
    private var isDocumentPhotoStateFinish: Bool = false
    private var isSelfiePhotoStateFinish: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cameraManager = CameraManager(delegate: self)
        self.cameraManager?.setPosition(position: .front)
        self.cameraManager?.initialized()
        contentView.captureButton.addTarget(self, action: #selector(self.takePhotoTapped), for: .touchUpInside)
        isSelfiePhotoStateFinish = false
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.showAlertMessage(title: "Take a selfie", message: "This is the last step")
    }
    
    override func viewDidLayoutSubviews() {
        
        self.cameraManager?.didLayout()
    }
    
    
    @objc func takePhotoTapped() {
        
        contentView.captureButton.isEnabled = false
        self.cameraManager?.takePhoto()
    }
    
    
    func didUploadDocumentPhoto(state: Bool) {
        
        DispatchQueue.main.async {
            
            if (!state) {
                
                self.showAlertError(message: "Failed to upload the document photo")
            }
            self.isDocumentPhotoStateFinish = true
            self.navigateToFinish()
        }
    }
    
    
    private func navigateToFinish() {
        
        if(isDocumentPhotoStateFinish && isSelfiePhotoStateFinish){
            
            self.stopSpinner()
            let vc = FinishViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension SelfieViewController: CameraManagerDelegate{
    
    
    func cameraPreviewView() -> UIView {
        
        return self.contentView.previewView
    }
    
    
    func cameraPhotoOut(capturedImage: UIImage?, error: Error?) {
        
        guard let image = capturedImage else {
            return
        }
        
        let network = NetworkManager()
        self.startSpinner()
        network.performPostMultipartsOperation(image: image, filename: "selfie", completionHandler: { response in
            
            DispatchQueue.main.async {
                
                if(response){
                    
                    self.isSelfiePhotoStateFinish = true
                    self.navigateToFinish()
                }else{
                    
                    self.contentView.captureButton.isEnabled = true
                    self.showAlertError(message: "Please take another photo")
                }
            }
        })
    }
}
