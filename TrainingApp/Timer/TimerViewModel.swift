//
//  TimerPresenter.swift
//  TrainingApp
//
//  Created by Артём Харченко on 24.07.2022.
//

import Foundation

class TimerViewModel {
    
    private var hours = Box(0)
    private var minutes = Box(0)
    private var seconds = Box(0)
    
    func setHours(to value: Int) {
        self.hours.value = value
        
    }
    
    func setMinutes(to value: Int) {
        var newMinutes = value
        if (value >= 60) {
            newMinutes -= 60
            hours.value += 1
        }
        
        self.minutes.value = newMinutes
    }
    
    func setSeconds(to value: Int) {
        var newSeconds = value
        
        if (value >= 60) {
            newSeconds -= 60
            minutes.value += 1
        }
        
        if minutes.value >= 60 {
            minutes.value -= 60
            hours.value += 1
        }
        
        self.seconds.value = newSeconds
    }
    
    func getHours() -> Box<Int> {
        return self.hours
    }
    
    func getMinutes() -> Box<Int> {
        return self.minutes
    }
    
    func getSeconds() -> Box<Int> {
        return self.seconds
    }
}

extension Int {
    func appendZeroes() -> String{
        if (self < 10) {
            return "0\(self)"
        } else {
            return "\(self)"
        }
    }
}
