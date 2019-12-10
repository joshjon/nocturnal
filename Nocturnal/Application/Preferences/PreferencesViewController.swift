//
//  GeneralViewController.swift
//  Nocturnal
//
//  Created by Joshua Jon on 10/12/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa

class PreferencesViewController: NSViewController {

    @IBOutlet weak var sourceCodeLabel: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewWillAppear() {
        StateManager.isPreferencesWindowOpen = true
    }
    
    override func viewWillDisappear() {
        StateManager.isPreferencesWindowOpen = false
    }
    
}
