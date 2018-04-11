//
//  ViewController.swift
//  PhotoChallenge
//
//  Created by Sebastian Prokesch on 18.03.18.
//  Copyright © 2018 Sebastian Prokesch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var test = OxfordDict()
        
        test.getDomains(forLanguage: OxfordDict.OxfordLanguage.Englisch) { (result, error) in
            print(result as! [String])
            var domainList = result as! [String]
            
            let randomIndex = Int(arc4random_uniform(UInt32(domainList.count)))
            print("\n\n\n Next! \n\n\n \(domainList[randomIndex]) \n\n\n")
            test.getWordList(forDomain: domainList[randomIndex]) { (result, error) in
                print(result as![String])
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

