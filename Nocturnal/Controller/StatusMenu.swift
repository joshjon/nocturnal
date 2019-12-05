//
//  StatusMenu.swift
//  Nocturnal
//
//  Created by Joshua Jon on 25/11/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa

class StatusMenu: NSMenu {
    @IBOutlet weak var nightShiftSliderView: NightShiftSliderView!
    @IBOutlet weak var dimnessSliderView: DimnessSliderView!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var storyboard = NSStoryboard(name: "Main", bundle: nil)
    var nightShiftSliderMenuItem: NSMenuItem!
    var dimnessSliderMenuItem: NSMenuItem!
    
    override func awakeFromNib() {
        setStatusMenuIcon()
        statusItem.menu = self
        setupNightShiftSliderMenuItem()
        setupDimnessSliderMenuItem()
    }
    
    func setStatusMenuIcon() {
        if let icon = NSImage(named:NSImage.Name("StatusBarButtonImage")) {
            icon.isTemplate = true
            DispatchQueue.main.async { self.statusItem.button?.image = icon }
        }
    }
    
    func setupNightShiftSliderMenuItem() {
        nightShiftSliderView.setup()
        nightShiftSliderMenuItem = self.item(withTitle: "Night Shift Slider")
        nightShiftSliderMenuItem.view = nightShiftSliderView
    }
    
    func setupDimnessSliderMenuItem() {
        dimnessSliderView.setup()
        dimnessSliderMenuItem = self.item(withTitle: "Dimness Slider")
        dimnessSliderMenuItem.view = dimnessSliderView
    }
    
    @IBAction func disableCustomTimeClicked(_ sender: NSMenuItem) {
        let disableCustomTimeWindow = storyboard.instantiateController(withIdentifier: "Custom Time Window Controller") as! NSWindowController
        disableCustomTimeWindow.showWindow(nil)
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NightShift.disable()
        NightShift.blueLightReductionAmount = 0
        NSApplication.shared.terminate(sender)
    }
    
}
