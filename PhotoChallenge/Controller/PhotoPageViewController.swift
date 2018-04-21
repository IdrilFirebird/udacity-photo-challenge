//
//  PhotoPageViewController.swift
//  PhotoChallenge
//
//  Created by Sebastian Prokesch on 16.04.18.
//  Copyright © 2018 Sebastian Prokesch. All rights reserved.
//

import UIKit

protocol PageViewContentDelegate {
    func updateContent(photos: [Photo]?)
}

class PhotoPageViewController: UIPageViewController, PageViewContentDelegate {
    
    var photos: [Photo]?
    var currentIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateContent(photos: self.photos)
        dataSource = self
    }

    func viewPhotoController(_ index: Int) -> PhotoViewController? {
        guard let storyboard = storyboard, let page = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController
            
            else {
            return nil
        }
        
        if photos?.count == 0 {
            return nil 
        } else {
            page.photo = photos?[index]
            page.photoIndex = index
        }
        
        return page
        
    }
    
    
    func updateContent(photos: [Photo]?) {
        self.photos = photos
        if let vC = viewPhotoController(currentIndex ?? 0) {
            let vCs = [vC]
            setViewControllers(vCs, direction: .forward, animated: true, completion: nil)
        }
    }


}

extension PhotoPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        if let viewController = viewController as? PhotoViewController,
            let index = viewController.photoIndex,
            index > 0 {
            return viewPhotoController(index - 1)
        }
        
        return nil
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
       
        if let viewController = viewController as? PhotoViewController,
            let index = viewController.photoIndex,
            (index + 1) < (photos?.count)! {
            return viewPhotoController(index + 1)
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return (photos?.count)!
    }
    
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex ?? 0
    }
}
