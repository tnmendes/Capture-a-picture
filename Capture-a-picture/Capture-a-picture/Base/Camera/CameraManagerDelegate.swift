//
//  CameraManagerDelegate.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 16/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

import Foundation
import UIKit

protocol CameraManagerDelegate: class {
    
    func cameraPreviewView() -> UIView
    
    func cameraPhotoOut(capturedImage:UIImage?, error: Error?)
        
}
