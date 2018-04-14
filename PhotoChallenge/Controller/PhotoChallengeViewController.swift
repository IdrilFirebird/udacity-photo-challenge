//
//  PhotoChallengeViewController.swift
//  PhotoChallenge
//
//  Created by Sebastian Prokesch on 11.04.18.
//  Copyright © 2018 Sebastian Prokesch. All rights reserved.
//

import UIKit
import CoreData

class PhotoChallengeViewController: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var photoChallengeName: UILabel!
    @IBOutlet weak var challengeDomain: UILabel!
    @IBOutlet weak var dateCreated: UILabel!
    
    var photoChallenge: PhotoChallenge!
    var picker: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        picker.delegate = self
        
        do {
            try fetchResultsController.performFetch()
        } catch let error as NSError {
            print(error)
        }
        
        photoChallengeName.text = photoChallenge.challenge
        challengeDomain.text = photoChallenge.challengeDomain
        dateCreated.text = dateToString(photoChallenge.dateCreated! as Date)
        
        if let photo = fetchResultsController.fetchedObjects?.last as? Photo {
            imageView.image = UIImage(data: photo.photo! as Data)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: GestureRecognizer
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        showActionSheet()
    }
    
    func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        
        return formatter.string(from: date)
    }

    

    func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(alert: UIAlertAction!) -> Void in self.startPicker(pickerType: .camera)}))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(alert: UIAlertAction!) -> Void in self.startPicker(pickerType: .photoLibrary)}))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Core Data
    
    lazy var fetchResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        fr.predicate = NSPredicate(format: "challenge == %@", self.photoChallenge)
//        let challengeSortDescriptor = NSSortDescriptor(key: "dateTaken", ascending: false)
        fr.sortDescriptors = []//challengeSortDescriptor]
        
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: CoreDataStack.sharedInstance().managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController.delegate = self
        return fetchResultsController
    }()

}
