//
//  NetworkManager.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 16/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//

//setenv("CFNETWORK_DIAGNOSTICS", "1", 1); debug network

import Alamofire

class NetworkManager {

    
    func performPostMultipartsOperation(image: UIImage, completionHandler: @escaping (Bool) -> Void) {
        
        Alamofire.upload(
            multipartFormData: { MultipartFormData in
                
                MultipartFormData.append(UIImageJPEGRepresentation(image, 0.25)!, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpeg")
                
        }, to: Configuration.kBucket()) { (result) in
            
            switch result {
            case .success(_, _, _):

                completionHandler(true)
                break
            case .failure(let encodingError):
                
                print(encodingError)
                completionHandler(false)
                break
            }
        }
    }
    
}
