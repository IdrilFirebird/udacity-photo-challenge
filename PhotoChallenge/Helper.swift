//
//  Helper.swift
//  PhotoChallenge
//
//  Created by Sebastian Prokesch on 21.04.18.
//  Copyright © 2018 Sebastian Prokesch. All rights reserved.
//

import UIKit


func dateToString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MM-YYYY"
    
    return formatter.string(from: date)
}


func showErrorAlert(viewController: UIViewController, message: String, dismissButtonTitle: String = "OK") {
    let controller = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    
    controller.addAction(UIAlertAction(title: dismissButtonTitle, style: .default) { (action: UIAlertAction!) in
        controller.dismiss(animated: true, completion: nil)
    })
    
    viewController.present(controller, animated: true, completion: nil)
}

