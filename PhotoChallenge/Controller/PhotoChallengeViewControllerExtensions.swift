//
//  PhotoChallengeViewControllerExtensions.swift
//  PhotoChallenge
//
//  Created by Sebastian Prokesch on 14.04.18.
//  Copyright © 2018 Sebastian Prokesch. All rights reserved.
//

import UIKit

// MARK: Extension for Image Picking either by cam or lib

extension PhotoChallengeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func startPicker(pickerType: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(pickerType) {
            picker.sourceType = pickerType
            picker.allowsEditing = true
            if (pickerType == .camera) {
                picker.showsCameraControls = true
            }
            present(picker, animated: true, completion: nil)
        } else if(pickerType == .camera) {
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            let _ = Photo(photo: UIImagePNGRepresentation(image)! as NSData, photoChallenge: self.photoChallenge, context: CoreDataStack.sharedInstance().managedObjectContext)
            CoreDataStack.sharedInstance().saveContext()
        } else {
            print("Image thing went wrong")
        }
        dismiss(animated: true, completion: nil)
    }
    
}
