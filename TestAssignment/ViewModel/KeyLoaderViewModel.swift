//
//  KeyLoaderViewModel.swift
//  TestAssignment
//
//  Created by Constantine Kulak on 04.08.2023.
//

import Foundation

class BaseENV {
    
    let dict: NSDictionary
    
    init(resourceName: String){
        guard let filePath = Bundle.main.path(forResource: resourceName, ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath)
        else {
            fatalError( "Couldn't find file plist")
        }
        self.dict = plist
    }
}


protocol APIKeyable {
    var APIKEY: String { get }
}

class ProdENV : BaseENV, APIKeyable {
    var APIKEY: String {
        dict.object(forKey: "APIKEY") as? String ?? ""
    }
    
    init() {
        super.init(resourceName: "API-KEY")
    }
}
