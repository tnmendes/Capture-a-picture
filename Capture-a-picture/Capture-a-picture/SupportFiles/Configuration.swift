//
//  Configuration.swift
//  Capture-a-picture
//
//  Created by Tiago Mendes on 16/10/2018.
//  Copyright © 2018 Tiago Mendes. All rights reserved.
//


struct Configuration {
    
    static let kApiURL = "https://labs.signicat.com/"
    
    static func kBucket() -> String {
        return kApiURL + "notifications/home/receive"
    }
}
