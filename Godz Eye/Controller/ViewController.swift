//
//  ViewController.swift
//  Godz Eye
//
//  Created by Antoine Perry on 12/19/19.
//  Copyright © 2019 Antoine Perry. All rights reserved.
//

import UIKit
import SwiftyJSON


class ViewController: UIViewController {
    
    var imagePicker = UIImagePickerController()
    let networkingClient = NetworkingClient()
    

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        handleImagePicker()
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        imageView.image = userPickedImage
    
       
        let imageData = userPickedImage.jpegData(compressionQuality: 1)!
        //let imageString = imageData.base64EncodedString()
        
        networkingClient.executeNetworkRequest(imageData: imageData)
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
//func requestImageData (userPickedImage: UIImage) {
//
//        let chosenImage = userPickedImage
//        let imageData = chosenImage.jpegData(compressionQuality: 1)
//        guard let url = URL(string: "https://api.openalpr.com/v2/recognize?secret_key=\(secertKey)&recognize_vehicle=1&country=us&return_image=0&topn=1") else {
//            fatalError("Openalpr url not working")
//        }
//        let boundary = "Boundary-\(UUID().uuidString)"
//
//        var request = URLRequest.init(url: url)
//        request.httpMethod = "POST"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        request.setValue("applicaction/json", forHTTPHeaderField: "charset=utf-8")
//        request.httpBody = imageData
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let data = data {
//                let dataString = String(data: data, encoding: String.Encoding.utf8)
//                print(dataString!)
//            } else {
//                print(error ?? "Error with data in OpenALPR URLSession task")
//            }
//        }
//        task.resume()
//    }
//
//    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
//
//        let body = Data()
//
//        if parameters != nil {
//            body.a
//        }
//
//
//        return body
//    }
    

