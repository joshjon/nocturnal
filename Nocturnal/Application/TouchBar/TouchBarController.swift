//
//  TouchBar.swift
//  Nocturnal
//
//  Created by Joshua Jon on 7/6/20.
//  Copyright © 2020 Joshua Jon. All rights reserved.
//

import Cocoa

class TouchBarController: NSObject, NSTouchBarDelegate {
    static let touchBarController = TouchBarController()
    var touchBar: NSTouchBar!
    
    func hideTouchBar() {
        // Will need to add escape key here
        touchBar = NSTouchBar()
        presentTouchBar()
    }
    
    @objc private func presentTouchBar() {
        presentSystemModal(touchBar, placement: 1, systemTrayItemIdentifier: .nocturnalControlStripItem)
    }
    
    func presentSystemModal(_ touchBar: NSTouchBar!, placement: Int64, systemTrayItemIdentifier identifier: NSTouchBarItem.Identifier!) {
        if #available(OSX 10.14, *) {
            NSTouchBar.presentSystemModalTouchBar(touchBar, placement: placement, systemTrayItemIdentifier: identifier)
        } else {
            NSTouchBar.presentSystemModalFunctionBar(touchBar, placement: placement, systemTrayItemIdentifier: identifier)
        }
    }
    
}

extension NSTouchBarItem.Identifier {
    static let nocturnalControlStripItem = NSTouchBarItem.Identifier("com.joshua.jon.Nocturnal.controlStrip")
}
