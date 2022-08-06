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
    func setSeconds(to value: Int)
    func setMinutes(to value: Int)
    
    var viewModelDidChange:((TimerViewModelProtocol) -> Void)? { get set }
    init(timer: Timer)
}

class TimerViewModel: TimerViewModelProtocol {
    var timer = Timer()
    
    var hours: Int {
        get {
            return timer.hours
        } set {
            timer.hours = newValue
            viewModelDidChange?(self)
        }
    }
    
    var minutes: Int {
        get {
            return timer.minutes
        } set {
            timer.minutes = newValue
            viewModelDidChange?(self)
        }
    }
    
    var seconds: Int {
        get {
            return timer.seconds
        } set {
            timer.seconds = newValue
            viewModelDidChange?(self)
        }
    }
    
    var viewModelDidChange: ((TimerViewModelProtocol) -> Void)?
    
    //MARK: - SetMethods
    func setHours(to value: Int) {
        self.hours = value
    }
    
    func setMinutes(to value: Int) {
        var newMinutes = value
        if (value >= 60) {
            newMinutes -= 60
            hours += 1
        }
        
        self.minutes = newMinutes
    }

    func setSeconds(to value: Int) {
        var newSeconds = value

        if (value >= 60) {
            newSeconds -= 60
            minutes += 1
        }

        if minutes >= 60 {
            minutes -= 60
            hours += 1
        }

        self.seconds = newSeconds
    }
    
    required init(timer: Timer) {
        self.timer = timer
    }
}

//MARK: - Extantion
extension Int {
    func appendZeroes() -> String {
        if (self < 10) {
            return "0\(self)"
        } else {
            return "\(self)"
        }
    }
}
