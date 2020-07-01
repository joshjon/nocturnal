//
//  TouchBar.swift
//  Nocturnal
//
//  Created by Joshua Jon on 7/6/20.
//  Copyright © 2020 Joshua Jon. All rights reserved.
//

import Cocoa

class TouchBarController: NSObject {
    static let shared = TouchBarController()
    var blankTouchBar = NSTouchBar()

    func hideTouchBar() {
        presentSystemModal(blankTouchBar, placement: 1, systemTrayItemIdentifier: .nocturnalControlStripItem)
    }

    func showTouchbar() {
        minimizeSystemModal(blankTouchBar)
    }

    func presentSystemModal(_ touchBar: NSTouchBar!, placement: Int64, systemTrayItemIdentifier identifier: NSTouchBarItem.Identifier!) {
        if #available(OSX 10.14, *) {
            NSTouchBar.presentSystemModalTouchBar(touchBar, placement: placement, systemTrayItemIdentifier: identifier)
        } else {
            NSTouchBar.presentSystemModalFunctionBar(touchBar, placement: placement, systemTrayItemIdentifier: identifier)
        }
    }

    func minimizeSystemModal(_ touchBar: NSTouchBar!) {
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
