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
        
    
        let imageData = UIImage.fixedImageOrientation(userPickedImage)
        
        
        networkingClient.executeNetworkRequest(imageData: imageData())
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
    

