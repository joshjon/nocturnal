//
//  CustomTimeViewController.swift
//  Nocturnal
//
//  Created by Joshua Jon on 2/12/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa

class CustomTimeViewController: NSViewController {
    
    var disableCustomTime: ((Int) -> Void)?
    var timer: Timer?
    let calendar = NSCalendar(identifier: .gregorian)!
    
    @IBOutlet weak var minutesTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func applyButtonClicked(_ sender: NSButton) {
        disableCustomTime = { (timeIntervalInSeconds) in
            let disableTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(timeIntervalInSeconds),
                                                    repeats: false,
                                                    block: { _ in
                                                        StateManager.disableTimer = .off
                                                        StateManager.respond(to: .disableTimerEnded)
            })
            disableTimer.tolerance = 60
            
            let currentDate = Date()
            var addComponents = DateComponents()
            addComponents.second = timeIntervalInSeconds
            let disabledUntilDate = self.calendar.date(byAdding: addComponents, to: currentDate, options: [])
            
            StateManager.disableTimer = .custom(timer: disableTimer, endDate: disabledUntilDate!)
            StateManager.respond(to: .disableTimerStarted)
        }
        
        let minutes = minutesTextField.intValue
        let timeIntervalInSeconds = minutes
        disableCustomTime?(Int(timeIntervalInSeconds))
        
        self.view.window?.close()
    }
    
    @IBAction func cancelButtonClicked(_ sender: NSButton) {
        self.view.window?.close()
    }
    
}
