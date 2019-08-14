//
//  DatePickerViewController.swift
//  OutaTime
//
//  Created by Eoin Lavery on 13/08/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import UIKit

//Delegate to handle the selection of a Destination Date
protocol DatePickerDelegate {
    func destinationWasChosen(date: Date)
}

class DatePickerViewController: UIViewController {

    //UI Elements declarations
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //Delegate declaration
    var delegate: DatePickerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //Actions to be handled when cancel is tapped
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //Actions to be handled when done is tapped
    @IBAction func doneTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.destinationWasChosen(date: datePicker.date)
    }
    
}
