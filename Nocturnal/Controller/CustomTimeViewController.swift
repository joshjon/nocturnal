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

    @IBOutlet weak var minutesTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func applyButtonClicked(_ sender: NSButton) {
        let minutes = minutesTextField.intValue
        disableCustomTime?(Int(minutes * 60))
        NightShift.disable()
        Dimness.disable()
        
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { timer in
            NightShift.enable()
            Dimness.enable()
        })
        
        self.view.window?.close()
    }
    
    @IBAction func cancelButtonClicked(_ sender: NSButton) {
        self.view.window?.close()
    }
}
