//
//  StorageManager.swift
//  Countries
//
//  Created by Олег Федоров on 27.11.2021.
//

import Foundation

class StorageManager {
    
    static let checkedNameArrayKey = "checkedNameArrayKey"
    
    static func checkedNamesArray() -> [String]? {
        
        let defaults = UserDefaults.standard
        
        return defaults.array(forKey: StorageManager.checkedNameArrayKey) as? [String]? ?? []
        
    }
        
    static func setCheckedNamesArray(array: [String]) {
        
        let defaults = UserDefaults.standard
        defaults.set(array, forKey: StorageManager.checkedNameArrayKey)
        defaults.synchronize()
        
    }
    
}
