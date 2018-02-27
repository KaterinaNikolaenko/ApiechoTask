//
//  MainViewModel.swift
//  ApiechoTask
//
//  Created by Katerina on 27.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation

class MainViewModel: NSObject {
    
    var itemsArray = [String]()
    var dictCharacters = [Character : Int]()
    
    // Log in to Server
    func getText(completion: @escaping (Bool) -> ()) {
        
        HttpClient.sharedInstance.getText(successCallback: { (dataResponse) -> Void in
            if dataResponse.dataText != "" {
                let allString = dataResponse.dataText.lowercased()
                for letter in allString {
                    if let count = self.dictCharacters[letter]{
                        self.dictCharacters[letter] = count  + 1
                    } else {
                        self.dictCharacters[letter] = 1
                    }
                }
                let newDictionary = self.dictCharacters.sortedByValue
                for (key, value) in newDictionary {
                    if key == " " {
                        self.itemsArray.append("space - " +  String(describing: value) + " times")
                    } else {
                        self.itemsArray.append(String(describing: key) + " - " +  String(describing: value) + " times")
                    }
                }
            }
            completion(true)
        }) { (error) -> Void in
            completion(false)
        }
    }
}

