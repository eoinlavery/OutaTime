//
//  TimeCircuitsViewController.swift
//  OutaTime
//
//  Created by Eoin Lavery on 13/08/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import UIKit

class TimeCircuitsViewController: UIViewController {

    //UI Element Declarations
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var presentTimeLabel: UILabel!
    @IBOutlet weak var lastTimeDepartedLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    //Variable to hold current speed property
    var currentSpeed: Int = 0
    
    //Variable to hold Timer property
    private var timer: Timer?
    
    //Date Formatter designed to return Month, Day, Year formatting
    var dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentTimeLabel.text = dateFormatter.string(from: Date())
        speedLabel.text = String(currentSpeed)
        lastTimeDepartedLabel.text = "--- -- ----"
        
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ModalDestinationDatePickerSegue" {
            guard let destinationVC = segue.destination as? DatePickerViewController else { return }
            destinationVC.delegate = self
        }
    }
    
    
    // MARK: - Private Functions
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: updateSpeed(timer:))
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func showAlert(newDate: String) {
        let alert = UIAlertController(title: "Time Travcel Successful", message: "Your new date is \(newDate).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func updateSpeedLabel(timer: Timer) {
        
        while currentSpeed < 88 {
            currentSpeed += 1
            speedLabel.text = String(currentSpeed)
        }
        
        resetTimer()
        lastTimeDepartedLabel.text = presentTimeLabel.text
        presentTimeLabel.text = destinationLabel.text
        currentSpeed = 0
        
        guard let newDate = presentTimeLabel.text else { return }
        showAlert(newDate: newDate)
    }
    
    private func updateSpeed(timer: Timer) {
        
        if currentSpeed <= 88 {
            speedLabel.text = String(currentSpeed)
            currentSpeed += 1
        } else {
            resetTimer()
            lastTimeDepartedLabel.text = presentTimeLabel.text
            presentTimeLabel.text = destinationLabel.text
            currentSpeed = 0
            
            guard let newDate = presentTimeLabel.text else { return }
            showAlert(newDate: newDate)
        }
    }
    
    //Actions to be called when Travel Back button is pressed
    @IBAction func travelBack(_ sender: Any) {
        startTimer()
    }
    
}

//MARK: - Protocol Conformity
extension TimeCircuitsViewController: DatePickerDelegate {
    
    func destinationWasChosen(date: Date) {
        destinationLabel.text = dateFormatter.string(from: date)
    }
    
}
