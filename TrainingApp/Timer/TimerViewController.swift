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
            timerViewModel.viewModelDidChange = { [unowned self] viewModel in
                setHoursValue(to: viewModel.hours)
                setMinutesValue(to: viewModel.minutes)
                setSecondsValue(to: viewModel.seconds)
            }
            hourTextField.text = timerViewModel.hours.appendZeroes()
            minuteTextField.text = timerViewModel.minutes.appendZeroes()
            secondTextField.text = timerViewModel.seconds.appendZeroes()
        }
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        timerViewModel = TimerViewModel(timer: TimerState(
            hours: 00,
            minutes: 00,
            seconds: 05,
            timeStamp: 0
        ))
        
        [hourTextField, minuteTextField, secondTextField].forEach {
            $0?.attributedPlaceholder = NSAttributedString(
                string: "00",
                attributes: [NSAttributedString.Key.font: UIFont(
                    name: "Kohinoor Gujarati Bold",
                    size: 60.0)!,
                             NSAttributedString.Key.foregroundColor: UIColor.black]
            )
            $0?.delegate = self
        }
    }
    
    //MARK: - SetMethods
    func setHoursValue(to value: Int) {
        hourTextField.text = value.appendZeroes()
    }
    
    func setMinutesValue(to value: Int) {
        minuteTextField.text = value.appendZeroes()
    }
    
    func setSecondsValue(to value: Int) {
        secondTextField.text = value.appendZeroes()
    }
    
    //MARK: - textFieldInputChanged
    func textFieldInputChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        switch textField {
        case hourTextField:
            guard let hours = Int(text) else { return }
            timerViewModel.setHours(to: hours)
            
        case minuteTextField:
            guard let minutes = Int(text) else { return }
            timerViewModel.setMinutes(to: minutes)
            
        case secondTextField:
            guard let seconds = Int(text) else { return }
            timerViewModel.setSeconds(to: seconds)
        default:
            break
        }
    }
    
    //MARK: - @IBActions
    @IBAction func startTimer(_ sender: Any) {
        guard let timerCircleVC = storyboard?.instantiateViewController(
            withIdentifier: "circle") as? TimerCircleViewController else { return }
        timerViewModel.computeSeconds()
        timerCircleVC.timerViewModel = timerViewModel
        present(timerCircleVC, animated: true)
    }
}

    //MARK: - UITextFieldDelegate
extension TimerViewController: UITextFieldDelegate {
    // ограничение до 2х символов
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLenght = 2
        
        let currentText: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentText.replacingCharacters(
            in: range,
            with: string
        ) as NSString
        
        //проверяем с какого места начинается печать
        guard let text = textField.text else { return false }
        if (text.count == 2 && text.starts(with: "0")) {
            textField.text?.removeFirst()
            textField.text! += string
            textFieldInputChanged(textField)
        }
    
        return newString.length <= maxLenght
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

