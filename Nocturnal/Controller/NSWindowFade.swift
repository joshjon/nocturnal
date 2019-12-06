//
//  NSWindowFade.swift
//  Nocturnal
//
//  Created by Joshua Jon on 6/12/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa

private let defaultWindowAnimationDuration: TimeInterval = 0.25

public extension NSWindow {
    
    typealias AnimationCompletionHandler = () -> Void
    
    func fadeIn(sender: Any?, duration: TimeInterval, timingFunction: CAMediaTimingFunction? = .default, startingAlpha: CGFloat = 0, targetAlpha: CGFloat, completionHandler: AnimationCompletionHandler? = nil) {
        alphaValue = startingAlpha
        self.orderFrontRegardless()
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = duration
            context.timingFunction = timingFunction
            animator().alphaValue = targetAlpha
        }, completionHandler: completionHandler)
    }
    
    func fadeOut(sender: Any?, duration: TimeInterval, timingFunction: CAMediaTimingFunction? = .default, targetAlpha: CGFloat = 0, resetAlphaAfterAnimation: Bool = true, completionHandler: AnimationCompletionHandler? = nil) {
        let startingAlpha = self.alphaValue
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = duration
            context.timingFunction = timingFunction
            animator().alphaValue = targetAlpha
        }, completionHandler: { [weak weakSelf = self] in
            guard let weakSelf = weakSelf else { return }
            self.orderOut(sender)
            if resetAlphaAfterAnimation { weakSelf.alphaValue = startingAlpha }
            completionHandler?()
        })
    }
}

public extension CAMediaTimingFunction {
    static let `default` = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
}
