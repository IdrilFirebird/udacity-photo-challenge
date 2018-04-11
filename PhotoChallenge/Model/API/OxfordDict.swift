//
//  OxfordDict.swift
//  PhotoChallenge
//
//  Created by Sebastian Prokesch on 26.03.18.
//  Copyright © 2018 Sebastian Prokesch. All rights reserved.
//

import Foundation


class OxfordDict {
    static let urlScheme = "https"
    static let apiHost = "od-api.oxforddictionaries.com/api/v1"
    static let oxfordAppID = "48902197"
    static let oxfordAPIKey = "b582631d2bce099d4922237c4675caec"
    
    // Wordlist random search
    // Domains search before
    
    enum OxfordLanguage: String {
        case Englisch = "en"
        case Spanish = "es"
        case German = "de"
        case Portuguese = "pt"
    }
    
    

    func getWordList(forDomain: String, handler: @escaping (AnyObject?, NSError?) -> Void) {
        let domainPath = "/lexicalCategory=Noun;domains=\(forDomain)"
        let urlString = OxfordDict.urlScheme + "://" + OxfordDict.apiHost + "/wordlist" + "/\(OxfordLanguage.Englisch.rawValue)" + domainPath
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        
        request.addValue(OxfordDict.oxfordAppID, forHTTPHeaderField: "app_id")
        request.addValue(OxfordDict.oxfordAPIKey, forHTTPHeaderField: "app_key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        taskForGetRequest(urlRequest: request) {(result, error) in
            if (error != nil) {
                // DO Something with the error
                
            }
            
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: result as! Data, options: .allowFragments) as! [String:AnyObject]
            } catch {
                self.sendError("Could not parse the data as JSON: '\(result)'", handler: handler)
                return
            }
            
            
            /* GUARD: Did Oxford return any results? */
            guard let results = parsedResult["results"] as? [AnyObject] else {
                self.sendError("there where no results in \(parsedResult)", handler: handler)
                return
            }
            
            var resultsArray : [String] = []
            
            for result in results {
                resultsArray.append(result["word"] as! String)
            }
            
            
            handler(resultsArray as AnyObject, nil)
            
        }
        
    }
    
    func getDomains(forLanguage: OxfordLanguage, handler: @escaping (AnyObject?, NSError?) -> Void) {
        
        let urlString = OxfordDict.urlScheme + "://" + OxfordDict.apiHost + "/domains" + "/\(forLanguage.rawValue)"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        
        
        request.addValue(OxfordDict.oxfordAppID, forHTTPHeaderField: "app_id")
        request.addValue(OxfordDict.oxfordAPIKey, forHTTPHeaderField: "app_key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        taskForGetRequest(urlRequest: request) {(result, error) in
            if (error != nil) {
                // DO Something with the error
                
            }
            
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: result as! Data, options: .allowFragments) as! [String:AnyObject]
            } catch {
                self.sendError("Could not parse the data as JSON: '\(result)'", handler: handler)
                return
            }
            
            
            /* GUARD: Did Oxford return any results? */
            guard let results = parsedResult["results"] as? [String:AnyObject] else {
                self.sendError("there where no results in \(parsedResult)", handler: handler)
                return
            }
            let resultsArray = Array(results.keys) as [String]
            handler(resultsArray as AnyObject, nil)
            
        }
        
    }
    
    
    func taskForGetRequest(urlRequest: URLRequest, responseHandler: @escaping (_ result: AnyObject?, _ error: NSError?)-> Void){
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                self.sendError(error!.localizedDescription, handler: responseHandler)
                responseHandler(nil, NSError(domain: "execRequest", code: 1, userInfo: [NSLocalizedDescriptionKey: error!.localizedDescription]))
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                self.sendError("Status code returned other than 2xx!", handler: responseHandler)
                return
            }
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                self.sendError("There was no Data returned.", handler: responseHandler)
                return
            }
            
            responseHandler(data as AnyObject, nil)
        
        }
        task.resume()
    }
    
    
    
    // MARK: Helper functions
    
    private func sendError(_ error: String, handler: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        print(error)
        let userInfo = [NSLocalizedDescriptionKey : error]
        handler(nil, NSError(domain: "execRequest", code: 1, userInfo: userInfo))
    }
    
}
