//
//  Timer.swift
//  TrainingApp
//
//  Created by Артём Харченко on 04.08.2022.
//

import Foundation

enum CountdownState {
    case suspended
    case running
    case paused
}

class Timer {
    var hours: Int 
    var minutes: Int
    var seconds: Int
    
    init(hours: Int = 0, minutes: Int = 0, seconds: Int = 0) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
}
