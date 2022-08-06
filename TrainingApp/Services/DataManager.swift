//
//  DataManager.swift
//  TrainingApp
//
//  Created by Артём Харченко on 24.07.2022.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults()
    
    private init() {}
    
    func setValue(for timerPart: String, with value: Int) {
        userDefaults.set(value, forKey: timerPart)
    }
    
    func getValue(for timerPart: String) -> Int {
        userDefaults.integer(forKey: timerPart)
    }
}
