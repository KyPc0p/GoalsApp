//
//  TimerCircleViewController.swift
//  TrainingApp
//
//  Created by Артём Харченко on 08.08.2022.
//

import UIKit

class TimerCircleViewController: UIViewController {
    
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var timerContainerView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var pauseResumeView: UIView!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var resetView: UIView!
    
    @IBOutlet weak var pauseResumeButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    //MARK: - Variables
    var timerViewModel: TimerViewModelProtocol!
    
    var totalSeconds = 0 {
        didSet {
            timerSeconds = totalSeconds
        }
    }
    
    var timerSeconds = 0
    
    let timerTrackLayer = CAShapeLayer()
    let timerCircleFillLayer = CAShapeLayer()
    var timerState: CountdownState = .suspended
    var countdownTimer = Timer()
    
    //создание анимации
    lazy var timeerEndAnimation: CABasicAnimation = {
        let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        strokeEnd.toValue = 0
        strokeEnd.fillMode = .forwards
        strokeEnd.isRemovedOnCompletion = true
        return strokeEnd
    }()
    
    lazy var timerResetAnimation: CABasicAnimation = {
        let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        strokeEnd.toValue = 1
        strokeEnd.fillMode = .forwards
        strokeEnd.isRemovedOnCompletion = false
        return strokeEnd
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let time = self.timerViewModel.getTime()
        totalSeconds = time.seconds
        
        
        //скрываем кнопки
        [pauseResumeView, resetView].forEach {
            guard let view = $0 else { return }
            view.layer.opacity = 0
            view.isUserInteractionEnabled = false
        }
        
        [pauseResumeView, playView, resetView].forEach { $0?.layer.cornerRadius = 17 }
        
        timerView.transform = timerView.transform.rotated(by: 270.degreeFromRad())
        //        timerLabel.transform = timerLabel.transform.rotated(by: 90.degreeFromRad())
        timerContainerView.transform = timerContainerView.transform.rotated(by: 90.degreeFromRad())
        
        updatelabels()
    }
    
    //MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.setupLayers()
        }
    }
    
    //MARK: - @IBActions
    @IBAction func pauseResumeButtonPressed(_ sender: Any) {
        switch timerState {
        case .running:
            timerState = .paused
            timerCircleFillLayer.strokeEnd = CGFloat(timerSeconds) / CGFloat(totalSeconds)
            resetTimer()
            
            animatePauseButton(symbolName: "play.fill")
        case .paused:
            timerState = .running
            timeerEndAnimation.duration = Double(timerSeconds) + 1
            startTimer()
            
            animatePauseButton(symbolName: "pause.fill")
        default: break
        }
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        guard timerState == .suspended else { return }
        self.timeerEndAnimation.duration = Double(self.timerSeconds)
        //смена символа
        animatePauseButton(symbolName: "pause.fill")
        
        animatePlayPauseResetViews(timerPlaying: false)
        
        startTimer()
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        timerState = .suspended
        timerSeconds = totalSeconds
        resetTimer()
        
        timerCircleFillLayer.add(timerResetAnimation, forKey: "reset")
        
        animatePauseButton(symbolName: "play.fill")
        
        animatePlayPauseResetViews(timerPlaying: true)
    }
    
    //MARK: - Functions
    func setupLayers() {
        let radius = timerView.frame.width < timerView.frame.height ? timerView.frame.width / 2 : timerView.frame.height / 2
        let arcPath = UIBezierPath(arcCenter: CGPoint(x: timerView.frame.height / 2, y: timerView.frame.width / 2), radius: radius, startAngle: 0, endAngle: 360.degreeFromRad(),clockwise: true)
        //форма для линии
        timerTrackLayer.path = arcPath.cgPath
        timerTrackLayer.strokeColor = UIColor.systemCyan.cgColor
        timerTrackLayer.lineWidth = 20
        timerTrackLayer.fillColor = UIColor.clear.cgColor
        timerTrackLayer.lineCap = .round
        
        timerCircleFillLayer.path = arcPath.cgPath
        timerCircleFillLayer.strokeColor = UIColor.systemBlue.cgColor
        timerCircleFillLayer.lineWidth = 21
        timerCircleFillLayer.fillColor = UIColor.clear.cgColor
        timerCircleFillLayer.lineCap = .round
        timerCircleFillLayer.strokeEnd = 1 //??
        
        timerView.layer.addSublayer(timerTrackLayer)
        timerView.layer.addSublayer(timerCircleFillLayer)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.timerContainerView.layer.cornerRadius = self.timerContainerView.frame.width / 2
        }
    }
    
    func animatePauseButton(symbolName: String ) {
        UIView.transition(with: pauseResumeButton, duration: 0.3, options: .transitionCrossDissolve) {
            self.pauseResumeButton.setImage(UIImage(systemName: symbolName, withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)), for: .normal)
        }
    }
    
    func startTimer() {
        updatelabels()
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ timer in
            self.timerSeconds -= 1
            self.updatelabels()
            if (self.timerSeconds == 0) {
                timer.invalidate()
                self.resetButtonPressed(self)
            }
        }
        
        timerState = .running
        timerCircleFillLayer.add(self.timeerEndAnimation, forKey: "timerEnd")
    }
    
    func updatelabels() {
        let seconds = timerSeconds % 60
        let minutes = timerSeconds / 60 % 60
        let hours = timerSeconds / 3600
        
        if hours > 0 {
            let hourseCount = String(hours).count
            let minutesCount = String(minutes).count
            let secondsCount = String(seconds.appendZeroes()).count
            
            let timeString = "\(hours)h \(minutes)m \(seconds.appendZeroes())s"
            let semiBoldAtributes = [ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 18.0)! ]
            let attributedString = NSMutableAttributedString(string: timeString, attributes: semiBoldAtributes)
            
            attributedString.addAttributes(semiBoldAtributes, range: NSRange(location: 0, length: hourseCount))
            attributedString.addAttributes(semiBoldAtributes, range: NSRange(location: hourseCount + 2, length: minutesCount))
            attributedString.addAttributes(semiBoldAtributes, range: NSRange(location: hourseCount + 2 + minutesCount + 3, length: secondsCount))
            self.timerLabel.attributedText = attributedString
        } else {
            let minutesCount = String(minutes).count
            let secondsCount = String(seconds.appendZeroes()).count
            
            let timeString = "\(minutes)m \(seconds.appendZeroes())s"
            let attributedString = NSMutableAttributedString(string: timeString)
            
            attributedString.addAttributes(range: NSRange(location: 0, length: minutesCount))
            attributedString.addAttributes(range: NSRange(location: minutesCount + 3, length: secondsCount))
            timerLabel.attributedText = attributedString
        }
    }
    
    func resetTimer() {
        countdownTimer.invalidate()
        timerCircleFillLayer.removeAllAnimations()
        updatelabels()
    }
    
    ///логика исчезновения кнопок
    func animatePlayPauseResetViews(timerPlaying: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.playView.layer.opacity = timerPlaying ? 1 : 0
            self.pauseResumeView.layer.opacity = timerPlaying ? 0 : 1
            self.resetView.layer.opacity = timerPlaying ? 0 : 1
        } completion: { [weak self] _ in
            [self?.pauseResumeView, self?.resetView].forEach {
                guard let view = $0 else { return }
                view.isUserInteractionEnabled = timerPlaying ? false : true
            }
        }
    }
}

//MARK: - Extention
extension Double {
    func degreeFromRad() -> CGFloat {
        CGFloat(self * .pi) / 180
    }
}
