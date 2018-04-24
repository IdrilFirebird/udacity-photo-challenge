//
//  CreateChallengeViewController.swift
//  PhotoChallenge
//
//  Created by Sebastian Prokesch on 08.04.18.
//  Copyright © 2018 Sebastian Prokesch. All rights reserved.
//

import UIKit

class CreateChallengeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {


    @IBOutlet weak var domainPicker: UIPickerView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var pickerLabel: UILabel!
    
    let oxfordDict = OxfordDict()
    var domainPickerData: [String] = []
    var delegate: CreateChallengeViewControllerDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerLabel.text = "loading Domains"
        
        domainPicker.delegate = self
        domainPicker.dataSource = self
        
        
        getWordDomains()
    }

    fileprivate func getWordDomains() {
        oxfordDict.getDomains(forLanguage: OxfordDict.OxfordLanguage.Englisch) {(result, error) in
            if error == nil {
                self.domainPickerData = result as! [String]
                DispatchQueue.main.async {
                    self.domainPicker.reloadAllComponents()
                    self.domainLoadingFinished()
                }
                
            } else {
                DispatchQueue.main.async {
                    self.dismiss(animated: true) {
                    self.delegate?.showCreationError(errorMessage: "Something went wrong while getting Language Domains, pls try again later.")
                    }
                }
            }
            
        }
    }
    
    func domainLoadingFinished() {
        activitySpinner.stopAnimating()
        pickerLabel.text = "Select a domain"
        domainPicker.isHidden = false
    }
    
    func creatingChallengeSpinner() {
        activitySpinner.startAnimating()
        pickerLabel.text = "Creating Challenge"
        domainPicker.isHidden = true
    }
    

    @IBAction func createChallenge(_ sender: Any) {
        creatingChallengeSpinner()
        let doamin = domainPickerData[domainPicker.selectedRow(inComponent: 0)]
        oxfordDict.getWordList(forDomain: doamin) {(result, error) in
            if error == nil {
                let stringList = result as! [String]
                let randomIndex = Int(arc4random_uniform(UInt32(stringList.count)))
                
                _ = PhotoChallenge(challenge: stringList[randomIndex], challengeDomain: doamin, context: CoreDataStack.sharedInstance().managedObjectContext)
                CoreDataStack.sharedInstance().saveContext()
                
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    self.dismiss(animated: true) {
                        self.delegate?.showCreationError(errorMessage: "Couldn't create new Photo Challenge, please try again.")
                    }
                }
            }
        }
        
    }
    
    @IBAction func cancelCreation(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return domainPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return domainPickerData[row]
    }
    
}
