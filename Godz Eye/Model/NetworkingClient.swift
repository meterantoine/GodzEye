//
//  OpenalprAPI.swift
//  Godz Eye
//
//  Created by Antoine Perry on 12/19/19.
//  Copyright © 2019 Antoine Perry. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkingClient {
    
    
    func executeNetworkRequest(imageData: Data) {
        let url = "https://api.openalpr.com/v2/recognize?secret_key=sk_8d7f64e7cbf334a0203881d3&recognize_vehicle=1&country=us&return_image=0&topn=1"

        let headers: HTTPHeaders = [
            "Content-type" : "multipart/form-data"
        ]
        UploadImage(imageData: imageData, url: url, headers: headers)
    }
    
    func UploadImage(imageData: Data, url: String, headers: HTTPHeaders) {
        AF.upload(multipartFormData: { (formData) in
            formData.append(imageData, withName: "image", fileName: "image.png", mimeType: "image/png")
        }, to: url, method: .post, headers: headers).responseJSON { (response) in
            print(response.request!)
            print(response.result)
            print(response)
        }
    }
}


//class SendRequest {
//    
//    let secertKey = "sk_8d7f64e7cbf334a0203881d3"
//    
//    
//    
//    func ImageUrl() {
//        let urlString = "https://api.openalpr.com/v2/recognize?secret_key=\(secertKey)&recognize_vehicle=1&country=us&return_image=0&topn=1"
//        
//        performRequest(urlString: urlString)
//    }
//    
//    func performRequest(urlString: String) {
//        
//    }
//}

