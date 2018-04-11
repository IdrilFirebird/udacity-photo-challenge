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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerLabel.text = "loading Domains"
        
        domainPicker.delegate = self
        domainPicker.dataSource = self
        
        
        oxfordDict.getDomains(forLanguage: OxfordDict.OxfordLanguage.Englisch) {(result, error) in
            // TODO: show error alert
            
            if error == nil {
                self.domainPickerData = result as! [String]
                DispatchQueue.main.async {
                    self.domainPicker.reloadAllComponents()
                    self.domainLoadingFinished()
                }
               
            }
            
        }
    }

    func domainLoadingFinished() {
        activitySpinner.stopAnimating()
        pickerLabel.text = "Select a domain"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createChallenge(_ sender: Any) {
        let doamin = domainPickerData[domainPicker.selectedRow(inComponent: 0)]
        oxfordDict.getWordList(forDomain: doamin) {(result, error) in
            if error == nil {
                let stringList = result as! [String]
                let randomIndex = Int(arc4random_uniform(UInt32(stringList.count)))
                
                let photoChallenge = PhotoChallenge(challenge: stringList[randomIndex], challengeDomain: doamin, context: CoreDataStack.sharedInstance().managedObjectContext)
                CoreDataStack.sharedInstance().saveContext()
                
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
