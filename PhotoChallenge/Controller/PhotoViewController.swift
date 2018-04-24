//
//  PhotoViewController.swift
//  PhotoChallenge
//
//  Created by Sebastian Prokesch on 16.04.18.
//  Copyright © 2018 Sebastian Prokesch. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var photo: Photo!
    var photoIndex: Int!
    
    @IBOutlet weak var photoDate: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tabRecognizer)
        
        if let photo = photo {
            imageView.image = UIImage(data: photo.photo! as Data)
            photoDate.text = dateToString(photo.dateTaken! as Date)
        }
    }
    
    
    // MARK: Photo Fullscreen
    // only show photo with black background
    // code from https://stackoverflow.com/questions/34694377/swift-how-can-i-make-an-image-full-screen-when-clicked-and-then-original-size?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
    
    @objc
    func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.parent?.parent?.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
}
