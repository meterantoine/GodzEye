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
    
    
    func executeNetworkRequest(imageData: UIImage) {
        let secretKey = "Your secretKey"
        let url = "https://api.openalpr.com/v2/recognize?secret_key=\(secretKey)&recognize_vehicle=1&country=us&return_image=0&topn=1"

        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "accept": "application/json",
            
        ]
        
        AF.upload(multipartFormData: { (MultipartFormData) in
            guard let imgData = imageData.jpegData(compressionQuality: 1) else {return}
            MultipartFormData.append(imgData, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            
        }, to: url, method: .post, headers: headers).responseJSON { response in
            debugPrint(response)
        }
    }
}

