//
//  TouchBar.swift
//  Nocturnal
//
//  Created by Joshua Jon on 1/7/20.
//  Copyright © 2020 Joshua Jon. All rights reserved.
//

import Foundation

class TouchBar {
    private static let blankTouchBar = NSTouchBar()

    static func hideTouchBar() {
        if #available(OSX 10.14, *) {
            NSTouchBar.presentSystemModalTouchBar(blankTouchBar, placement: 1, systemTrayItemIdentifier: .nocturnalControlStripItem)
        } else {
            NSTouchBar.presentSystemModalFunctionBar(blankTouchBar, placement: 1, systemTrayItemIdentifier: .nocturnalControlStripItem)
        }
    }
    
    static func showTouchbar() {
        if #available(OSX 10.14, *) {
            NSTouchBar.minimizeSystemModalTouchBar(blankTouchBar)
        } else {
            NSTouchBar.minimizeSystemModalFunctionBar(blankTouchBar)
        }
    }
}

extension NSTouchBarItem.Identifier {
    static let nocturnalControlStripItem = NSTouchBarItem.Identifier("com.joshua.jon.Nocturnal.controlStrip")
}
