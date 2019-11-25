//
//  NightShiftSliderView.swift
//  Nocturnal
//
//  Created by Joshua Jon on 25/11/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa

class NightShiftSliderView: NSView {
    
    @IBOutlet weak var nightShiftSlider: NSSlider!
    
    func setup() {
        nightShiftSlider.isContinuous = true
        nightShiftSlider.minValue = 0
        nightShiftSlider.maxValue = 1
    }
    
    @IBAction func nightShiftSliderMoved(_ sender: NSSlider) {
        NightShift.setBlueLightReductionAmount(sender.floatValue)
    }
    
}
