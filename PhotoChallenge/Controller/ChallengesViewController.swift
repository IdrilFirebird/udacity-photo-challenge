//
//  ChallengesViewController.swift
//  PhotoChallenge
//
//  Created by Sebastian Prokesch on 31.03.18.
//  Copyright © 2018 Sebastian Prokesch. All rights reserved.
//

import UIKit
import CoreData

//protocol CreateChallengeDelegate {
//    func addPhotoChallenge(newChallenge: PhotoChallenge)
//}


class ChallengesViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    

    var insertedIndexPaths: [IndexPath]!
    var deletedIndexPaths : [IndexPath]!
    var updatedIndexPaths : [IndexPath]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhotoChallenge))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        
        do {
            try fetchResultsController.performFetch()
        } catch let error as NSError {
            print(error)
        }
        
        
    }
    
    // MARK: createChallengeDelegate

    @objc
    func addPhotoChallenge() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createPhotoChallengeController = storyboard.instantiateViewController(withIdentifier: "CreateChallengeViewController") as! CreateChallengeViewController
        self.present(createPhotoChallengeController, animated: true, completion: nil)
        
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultsController.sections!.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard  let sections = fetchResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoChallengeCell", for: indexPath)

        let photoChallenge = fetchResultsController.object(at: indexPath) as! PhotoChallenge
        cell.textLabel?.text =  photoChallenge.challenge
        cell.detailTextLabel?.text = dateToString(photoChallenge.dateCreated! as Date)
        if let challengePhotos = photoChallenge.photos?.allObjects as? [Photo] {
            if let photo = challengePhotos.first {
                cell.imageView?.image =  UIImage(data: photo.photo! as Data)
            }
        }
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let photoChallenge = fetchResultsController.object(at: indexPath)
            CoreDataStack.sharedInstance().managedObjectContext.delete(photoChallenge as! NSManagedObject)
            CoreDataStack.sharedInstance().saveContext()

        }
        
    }
 



    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "challengeDetailView" {
//            mapView.deselectAnnotation(sender as? MapPin, animated: false)
            let indexPath = self.tableView.indexPathForSelectedRow
            let destController = segue.destination as! PhotoChallengeViewController
            destController.photoChallenge = fetchResultsController.object(at: indexPath!) as! PhotoChallenge
            print("go to photo challenge detail view")
        }
    }
 
    
    // MARK: Core Data
    
    lazy var fetchResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "PhotoChallenge")
        let challengeSortDescriptor = NSSortDescriptor(key: "dateCreated", ascending: false)
        fr.sortDescriptors = [challengeSortDescriptor]
        
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: CoreDataStack.sharedInstance().managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController.delegate = self
        return fetchResultsController
    }()
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}
