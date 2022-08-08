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
    func computeSeconds()
    
    func getTime() -> TimerState
    
    var viewModelDidChange:((TimerViewModelProtocol) -> Void)? { get set }
}

class TimerViewModel: TimerViewModelProtocol {

    private var timer: TimerState
    
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
    
    func computeSeconds() {
        timer.seconds = (hours * 3600) + (minutes * 60) + seconds
        timer.timeStamp = Date().timeIntervalSince1970
    }
    
    func getTime() -> TimerState {
        return self.timer
    }

    //MARK: - SetMethods
    func setHours(to value: Int) {
        hours = value
    }
    
    func setMinutes(to value: Int) {
        var newMinutes = value
        if (value >= 60) {
            newMinutes -= 60
            hours += 1
        }
        
        minutes = newMinutes
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

        seconds = newSeconds
    }
    
    required init(timer: TimerState) {
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

