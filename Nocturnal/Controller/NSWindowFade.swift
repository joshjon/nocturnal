//
//  NSWindowFade.swift
//  Nocturnal
//
//  Created by Joshua Jon on 6/12/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa

public extension NSWindow {
    
    typealias AnimationCompletionHandler = () -> Void
    typealias desiredAlpha = () -> CGFloat
    
    func fadeInNew(duration: Double, completionHandler: AnimationCompletionHandler? = nil) {
        StateManager.isFadeInAnimationActive = true
        Dimness.isDimnessEnabled = true
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = duration
            animator().alphaValue = CGFloat(Dimness.getStrengthBeforeDisable())
        }, completionHandler: {
            StateManager.isFadeInAnimationActive = false
            completionHandler?()
        })
    }
    
    func fadeOutNew(duration: Double, completionHandler: AnimationCompletionHandler? = nil) {
        Dimness.setStrengthBeforeDisable(strength: alphaValue)
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = duration
            animator().alphaValue = 0
        }, completionHandler: {
            // Prevents race condition during animations when Nocturnal is disabled and then enabled in quick succession
            if !StateManager.isFadeInAnimationActive {
                Dimness.isDimnessEnabled = false
            }
            completionHandler?()
        })
    }
    
}
