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
    
    @IBOutlet weak var hoursTextField: NSTextField!
    @IBOutlet weak var minutesTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // only allow numbers
        hoursTextField.formatter = NumberFormatter()
        minutesTextField.formatter = NumberFormatter()
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
        
        let hours = hoursTextField.intValue
        let minutes = minutesTextField.intValue
        let timeInSeconds = hours * 3600 + minutes * 60
        disableCustomTime?(Int(timeInSeconds))
        closeWindow()
    }
    
    @IBAction func cancelButtonClicked(_ sender: NSButton) {
        StateManager.isCustomTimeWindowOpen = false
        closeWindow()
    }
    
    func closeWindow() {
        StateManager.isCustomTimeWindowOpen = false
        self.view.window?.close()
    }
    
    func setupWindow() {
        guard let window = self.view.window else { return }
        window.level = .floating
        window.orderFrontRegardless()
    }
    
}
