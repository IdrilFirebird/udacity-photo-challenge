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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let photo = photo {
            imageView.image = UIImage(data: photo.photo! as Data)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    
}
