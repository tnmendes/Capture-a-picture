//
//  CameraManager.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 15/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

import UIKit
import AVFoundation

class CameraManager: NSObject {
    
    weak var delegate: CameraManagerDelegate?
    
    private var captureSession: AVCaptureSession?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var capturePhotoOutput: AVCapturePhotoOutput?
    private var qrCodeFrameView: UIView?
    private var previewView: UIView!
    private var cameraPosition: AVCaptureDevice.Position = .back
    
    
    init(delegate: CameraManagerDelegate) {
        
        self.delegate = delegate
    }
    

    public func initialized() {
        
    
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: cameraPosition) else {
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
    
    
    public func getVideoPreviewLayer() -> AVCaptureVideoPreviewLayer? {
        
        return videoPreviewLayer
    }
    
    
    public func setPosition(position: AVCaptureDevice.Position) {
        self.cameraPosition = position
    }
    
    
    public func takePhoto(){
        
        guard let capturePhotoOutput = self.capturePhotoOutput else { return }
        let photoSettings = AVCapturePhotoSettings.init(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = .auto
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    
    public func didLayout(){
        
        self.videoPreviewLayer?.frame = (self.delegate?.cameraPreviewView().bounds)!
    }
}


extension CameraManager : AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard error == nil else {
            print("Fail to capture photo: \(String(describing: error))")
            self.delegate?.cameraPhotoOut(capturedImage: nil, error: error)
            return
        }
        
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

