//
//  TimerViewController.swift
//  TrainingApp
//
//  Created by Артём Харченко on 24.07.2022.
//

import UIKit

class TimerViewController: UIViewController {
   
    @IBOutlet weak var hourTextField: UITextField!
    @IBOutlet weak var minuteTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    
    var timerViewModel: TimerViewModelProtocol! {
        didSet {
            hourTextField.text = timerViewModel.hours.appendZeroes()
            minuteTextField.text = timerViewModel.minutes.appendZeroes()
            secondTextField.text = timerViewModel.seconds.appendZeroes()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerViewModel = TimerViewModel(timer: Timer(hours: 00, minutes: 00, seconds: 01))
        
        [hourTextField, minuteTextField, secondTextField].forEach {
            $0?.attributedPlaceholder = NSAttributedString(string: "00", attributes: [NSAttributedString.Key.font: UIFont(name: "Kohinoor Gujarati Bold", size: 60.0)!, NSAttributedString.Key.foregroundColor: UIColor.black])
            $0?.delegate = self
        }
        
//        timerViewModel.getHours()
//
//
//        timerViewModel.getMinutes { minutes in
//            self.minuteTextField.text = minutes.appendZeroes()
//        }
//
//        timerViewModel.getSeconds { seconds in
//            self.secondTextField.text = seconds.appendZeroes()
//        }
    }
    
    @objc func textFieldInputChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if textField == hourTextField {
            
            guard let hours = Int(text) else { return }
            timerViewModel.setHours(to: hours)
            
        } else if textField == minuteTextField {
            
            guard let minutes = Int(text) else { return }
//            timerViewModel.setMinutes(to: minutes)
            
        } else if textField == secondTextField {
            
            guard let seconds = Int(text) else { return }
//            timerViewModel.setSeconds(to: seconds)
            
        }
        
    }
    
    @IBAction func startTimer(_ sender: Any) {
    }
    
}

//MARK: - UITextFieldDelegate
extension TimerViewController: UITextFieldDelegate {
    // ограничение 2х символов, можно сделать проще
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLenght = 2
        
        let currentText: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentText.replacingCharacters(in: range, with: string) as NSString
        
        //проверяем с какого места начинается печать
        guard let text = textField.text else { return false}
        if (text.count == 2 && text.starts(with: "0")) {
            textField.text?.removeFirst()
            textField.text! += string
            self.textFieldInputChanged(textField)
        }
        
        return newString.length <= maxLenght
    }
//    не забыть добавить endEditing на таймер ???
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

