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

struct TimerState {
    var hours: Int 
    var minutes: Int
    var seconds: Int
    
    var timeStamp: Double
}

