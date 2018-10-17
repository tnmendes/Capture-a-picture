//
//  CameraManager.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 15/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class CameraManager: NSObject {
    
    weak var delegate: CameraManagerDelegate?
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var capturePhotoOutput: AVCapturePhotoOutput?
    var qrCodeFrameView: UIView?
    
    var previewView: UIView!
    
    init(delegate: CameraManagerDelegate) {
        
        self.delegate = delegate
    }
    
    
    func initialized() {
        
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            fatalError("No video device found")
        }
        
        do {
            
            previewView = self.delegate?.cameraPreviewView()
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            capturePhotoOutput = AVCapturePhotoOutput()
            capturePhotoOutput?.isHighResolutionCaptureEnabled = true
            captureSession?.addOutput(capturePhotoOutput!)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = previewView.layer.bounds
            previewView.layer.addSublayer(videoPreviewLayer!)
            captureSession?.startRunning()
    
        } catch {
            
            print(error)
            return
        }
    }
    
    
    func getVideoPreviewLayer() -> AVCaptureVideoPreviewLayer? {
        
        return videoPreviewLayer
    }
    
    
    public func takePhoto(){
        
        guard let capturePhotoOutput = self.capturePhotoOutput else { return }
        let photoSettings = AVCapturePhotoSettings.init(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = .auto
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
}


extension CameraManager : AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard error == nil else {
            print("Fail to capture photo: \(String(describing: error))")
            return
        }
        
        // Check if the pixel buffer could be converted to image data
        guard let imageData = photo.fileDataRepresentation() else {
            print("Fail to convert pixel buffer")
            return
        }
        
        guard let capturedImage = UIImage.init(data: imageData , scale: 1.0) else {
            print("Fail to convert image data to UIImage")
            return
        }
        
        self.delegate?.cameraPhotoOut(capturedImage: capturedImage, error: nil)

    }
    
}

