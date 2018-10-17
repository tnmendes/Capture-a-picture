//
//  CameraViewController.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 15/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

import UIKit
import AVFoundation


class CameraViewController: GenericViewController<CameraView> {
    
    var cameraManager: CameraManager?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        
        self.cameraManager = CameraManager(delegate: self)
        self.cameraManager?.initialized()
        contentView.captureButton.addTarget(self, action: #selector(self.takePhotoTapped), for: .touchUpInside)
    }
    

    override func orientation() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeRight
    }
    
    
    override func viewDidLayoutSubviews() {
        
        let videoPreviewLayer = self.cameraManager?.getVideoPreviewLayer()
        videoPreviewLayer?.frame = view.bounds
    }
    
    
    @objc func takePhotoTapped() {
        
        print("take photo")
        self.cameraManager?.takePhoto()
        
        //let vc = FinishViewController()
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension CameraViewController: CameraManagerDelegate{
    
    
    func cameraPreviewView() -> UIView {
        
        return self.contentView.previewView
    }
    
    
    func cameraPhotoOut(capturedImage: UIImage?, error: Error?) {
        
        let network = NetworkManager()
        if let image = capturedImage {
            
            network.performPostMultipartsOperation(image: image, completionHandler: { response in
                
                if(response){
                    print("Done")
                }else{
                    print("error")
                }
            })
        }
        
    }
}
