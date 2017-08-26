//
//  DateController.swift
//  GITList
//
//  Created by Kenny J Hong on 8/23/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit
import UserNotifications

class DateViewController: UIViewController {
    
    
    @IBAction func action(_ sender: Any) {
        
        let content = UNMutableNotificationContent()
        content.title = "Milk is expring in 2days"
        content.subtitle =  datePickerText.text!
        content.body = "This is body text lorem ipsum"
        content.badge = 1
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
    }
    
    @IBOutlet weak var datePickerText: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layer.cornerRadius = 5
        self.view.layer.borderWidth = 5
        self.view.layer.masksToBounds = true
        self.view.layer.borderColor = UIColor.white.cgColor

        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler:
        { didAllow, error in
        
        })
        createDatePicker()
        
        // Do any additional setup after loading the view.
    }
    
    func createDatePicker() {
        
        //format for picker
        datePicker.datePickerMode = .date
        
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        datePickerText.inputAccessoryView = toolbar
        
        //assinging date picker to text field
        datePickerText.inputView = datePicker
        
    }
    
    func donePressed() {
        
        // format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        datePickerText.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
}

