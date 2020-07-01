//
//  TouchBar.swift
//  Nocturnal
//
//  Created by Joshua Jon on 1/7/20.
//  Copyright © 2020 Joshua Jon. All rights reserved.
//

import Foundation


struct TouchBar {
    private static let blankTouchBar = NSTouchBar()
    
    static func hideTouchBar() {
        presentSystemModal(blankTouchBar, placement: 1, systemTrayItemIdentifier: .nocturnalControlStripItem)
    }

    static func showTouchbar() {
        minimizeSystemModal(blankTouchBar)
    }
    
    static func presentSystemModal(_ touchBar: NSTouchBar!, placement: Int64, systemTrayItemIdentifier identifier: NSTouchBarItem.Identifier!) {
        if #available(OSX 10.14, *) {
            NSTouchBar.presentSystemModalTouchBar(touchBar, placement: placement, systemTrayItemIdentifier: identifier)
        } else {
            NSTouchBar.presentSystemModalFunctionBar(touchBar, placement: placement, systemTrayItemIdentifier: identifier)
        }
    }

    static func minimizeSystemModal(_ touchBar: NSTouchBar!) {
        if #available(OSX 10.14, *) {
            NSTouchBar.minimizeSystemModalTouchBar(touchBar)
        } else {
            NSTouchBar.minimizeSystemModalFunctionBar(touchBar)
        }
    }
}

extension NSTouchBarItem.Identifier {
    static let nocturnalControlStripItem = NSTouchBarItem.Identifier("com.joshua.jon.Nocturnal.controlStrip")
}
