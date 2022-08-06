//
//  TimerPresenter.swift
//  TrainingApp
//
//  Created by Артём Харченко on 24.07.2022.
//

import Foundation

protocol TimerViewModelProtocol {
    var hours: Int { get }
    var minutes: Int { get }
    var seconds: Int { get }
    
    func setHours(to value: Int)
//    func setSeconds(to value: Int)
//    func setMinutes(to value: Int)
    
    func getHours() -> Int
    func getMinutes() -> Int
    func getSeconds() -> Int
    
    init(timer: Timer)
}

class TimerViewModel: TimerViewModelProtocol {
   
    var timer = Timer()
    
    var hours: Int {
        get {
            DataManager.shared.getValue(for: self.hours.appendZeroes())
        } set {
            DataManager.shared.setValue(for: hours.appendZeroes(), with: newValue)
        }
    }
    var minutes: Int {
        timer.minutes
    }
    var seconds: Int {
        timer.seconds
    }
    
    
    //MARK: - SetMethods
    func setHours(to value: Int) {
        self.hours = value
    }

//    func setMinutes(to value: Int) {
//        var newMinutes = value
//        if (value >= 60) {
//            newMinutes -= 60
//            hours += 1
//        }
//
//        self.minutes = newMinutes
//    }
//
//    func setSeconds(to value: Int) {
//        var newSeconds = value
//
//        if (value >= 60) {
//            newSeconds -= 60
//            minutes += 1
//        }
//
//        if minutes >= 60 {
//            minutes -= 60
//            hours += 1
//        }
//
//        self.seconds = newSeconds
//    }
    
    //MARK: - Get Methods
    func getHours() -> Int {
        self.hours
    }
    
    func getMinutes() -> Int{
        self.minutes
    }
    
    func getSeconds() -> Int{
        self.seconds
    }
    
    required init(timer: Timer) {
        self.timer = timer
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
