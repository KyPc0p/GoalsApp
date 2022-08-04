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
    
    var timerViewModel: TimerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timerViewModel = TimerViewModel()
        
        [hourTextField, minuteTextField, secondTextField].forEach {
            $0?.attributedPlaceholder = NSAttributedString(string: "00", attributes: [NSAttributedString.Key.font: UIFont(name: "Kohinoor Gujarati Bold", size: 60.0)!, NSAttributedString.Key.foregroundColor: UIColor.black])
            $0?.delegate = self
        }
        
        self.timerViewModel.getHours().bind { hours in
            self.hourTextField.text = hours.appendZeroes()
        }
        
        self.timerViewModel.getMinutes().bind { minutes in
            self.minuteTextField.text = minutes.appendZeroes()
        }
        
        self.timerViewModel.getSeconds().bind { seconds in
            self.secondTextField.text = seconds.appendZeroes()
            print(seconds)
        }
    }
    
    @objc func textFieldInputChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if textField == hourTextField {
            
            guard let hours = Int(text) else { return }
            timerViewModel.setHours(to: hours)
            
        } else if textField == minuteTextField {
            
            guard let minutes = Int(text) else { return }
            timerViewModel.setMinutes(to: minutes)
            
        } else if textField == secondTextField {
            
            guard let seconds = Int(text) else { return }
            timerViewModel.setSeconds(to: seconds)
            
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

