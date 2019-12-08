//
//  StatusMenu.swift
//  Nocturnal
//
//  Created by Joshua Jon on 25/11/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa

class StatusMenu: NSMenu, NSMenuDelegate{
    @IBOutlet weak var nightShiftSliderView: NightShiftSliderView!
    @IBOutlet weak var dimnessSliderView: DimnessSliderView!
    @IBOutlet weak var disableMenuItem: NSMenuItem!
    @IBOutlet weak var disableCustomMenuItem: NSMenuItem!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var storyboard = NSStoryboard(name: "Main", bundle: nil)
    var nightShiftSliderMenuItem: NSMenuItem!
    var dimnessSliderMenuItem: NSMenuItem!
    
    override func awakeFromNib() {
        delegate = self
        setStatusMenuIcon()
        statusItem.menu = self
        setupNightShiftSliderMenuItem()
        setupDimnessSliderMenuItem()
    }
    
    func menuWillOpen(_ menu: NSMenu) {
        updateMenu()
    }
    
    func updateMenu() {
        // Sliders
        if StateManager.isNocturnalEnabled {
            nightShiftSliderView.nightShiftSlider.isEnabled = true
            disableMenuItem.title = "Disable Nocturnal"
            dimnessSliderView.dimnessSlider.isEnabled = true
        } else {
            nightShiftSliderView.nightShiftSlider.isEnabled = false
            disableMenuItem.title = "Enable Nocturnal"
            dimnessSliderView.dimnessSlider.isEnabled = false
        }
        
        // Button toggles
        switch StateManager.disableTimer {
        case .off:
            disableCustomMenuItem.state = .off
            disableCustomMenuItem.isEnabled = true
        case .hour(timer: _):
            disableCustomMenuItem.state = .off
            disableCustomMenuItem.isEnabled = false
        case .custom(timer: _):
            disableCustomMenuItem.state = .on
            disableCustomMenuItem.isEnabled = true
        }
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
    
    @IBAction func disableClicked(_ sender: NSMenuItem) {
       if StateManager.isNocturnalEnabled {
            StateManager.respond(to: .userDisabledNocturnal)
        } else {
            StateManager.respond(to: .userEnabledNocturnal)
        }
    }
    
    @IBAction func disableCustomTimeClicked(_ sender: NSMenuItem) {
        let disableCustomTimeWindow = storyboard.instantiateController(withIdentifier: "Custom Time Window Controller") as! NSWindowController
        if disableCustomMenuItem.state == .off {
            NSApp.activate(ignoringOtherApps: true)
            disableCustomTimeWindow.showWindow(nil)
            disableCustomTimeWindow.window?.orderFrontRegardless()
        } else {
            StateManager.disableTimer = .off
            StateManager.respond(to: .disableTimerEnded)
        }
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        StateManager.isNocturnalEnabled = false
        NightShift.blueLightReductionAmount = 0
        NSApplication.shared.terminate(sender)
    }
    
}
