//
//  DimnessSliderView.swift
//  Nocturnal
//
//  Created by Joshua Jon on 19/11/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa

class DimnessSliderView: NSView {
    
    @IBOutlet weak var dimnessSlider: NSSlider!
    
    func setup() {
        dimnessSlider.isContinuous = true
        dimnessSlider.minValue = 0
        dimnessSlider.maxValue = 0.85
    }
    
    @IBAction func dimnessSliderMoved(_ sender: NSSlider) {
        let event = NSApplication.shared.currentEvent
        
        if event?.type == .leftMouseUp {
            Dimness.dimnessStrength = sender.floatValue
        } else {
            Dimness.updateDimnessStrength(sender.floatValue)
        }
    }
    
}
