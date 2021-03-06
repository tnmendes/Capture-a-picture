//
//  CameraView.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 16/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

import UIKit
import SnapKit


class CameraView: GenericView {
    
    private(set) var previewView = UIView()
    private(set) var captureButton = CaptureButton(type: UIButtonType.system)
    
    private let captureButtonSize: CGFloat = 80.0
    
    internal override func initializeUI() {
        
        addSubview(previewView)
        addSubview(captureButton)
        captureButton.bringSubview(toFront: captureButton)
    }
    
    
    internal override func createConstraints() {
        
        previewView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        captureButton.snp.makeConstraints { make in
            make.trailing.equalTo(previewView.snp.trailing).offset(-15)
            make.centerY.equalTo(previewView.snp.centerY)
            make.width.height.equalTo(captureButtonSize)
        }
    }
    
}
