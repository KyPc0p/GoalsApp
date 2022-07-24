//
//  AquaAddViewController.swift
//  TrainingApp
//
//  Created by Артём Харченко on 24.07.2022.
//

import UIKit
//этот экран будет сделан в Swift UI
class AquaAddViewController: UIViewController {

    @IBOutlet weak var aquaSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aquaSlider.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -2)
    }
    

    @IBAction func backButtonPressed() {
        dismiss(animated: false)
    }

}
