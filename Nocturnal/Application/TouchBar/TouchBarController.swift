//
//  TouchBar.swift
//  Nocturnal
//
//  Created by Joshua Jon on 7/6/20.
//  Copyright © 2020 Joshua Jon. All rights reserved.
//

import Cocoa

class TouchBarController: NSObject, NSTouchBarDelegate {
    static let shared = TouchBarController()
    var touchBar: NSTouchBar!
    
    func hideTouchBar() {
        touchBar = NSTouchBar()
        presentTouchBar()
    }
    
    func showTouchbar() {
        touchBar = NSTouchBar()
        dismissTouchbar()
    }
    
    @objc private func presentTouchBar() {
//        updateControlStripPresence()
//        presentSystemModal(touchBar, systemTrayItemIdentifier: .controlStripItem)
        presentSystemModal(touchBar, placement: 1, systemTrayItemIdentifier: .nocturnalControlStripItem)
    }
    
    @objc private func dismissTouchbar() {
        dismissSystemModal(touchBar)
    }
    
    func presentSystemModal(_ touchBar: NSTouchBar!, placement: Int64, systemTrayItemIdentifier identifier: NSTouchBarItem.Identifier!) {
        if #available(OSX 10.14, *) {
            NSTouchBar.presentSystemModalTouchBar(touchBar, placement: placement, systemTrayItemIdentifier: identifier)
        } else {
            NSTouchBar.presentSystemModalFunctionBar(touchBar, placement: placement, systemTrayItemIdentifier: identifier)
        }
    }
    
    func dismissSystemModal(_ touchBar: NSTouchBar!) {
        if #available(OSX 10.14, *) {
            NSTouchBar.dismissSystemModalTouchBar(touchBar)
        } else {
            NSTouchBar.dismissSystemModalFunctionBar(touchBar)
        }
    }
    
}

extension NSTouchBarItem.Identifier {
    static let nocturnalControlStripItem = NSTouchBarItem.Identifier("com.joshua.jon.Nocturnal.controlStrip")
}
