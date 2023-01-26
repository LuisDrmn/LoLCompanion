//
//  CompanionWindow.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 23/01/2023.
//

import Foundation
import AppKit
import SwiftUI

class CustomWindow: NSWindow {

    init(with rect: NSRect) {
        super.init(contentRect: rect, styleMask: [], backing: .buffered, defer: false)

        isReleasedWhenClosed = false

        self.hideWindow()

        let dragonManager = DDragonManager()

        let mainView = CompanionView()
            .environmentObject(dragonManager)
            .frame(width: rect.width, height: rect.height, alignment: .center)

        let hostingView = LoLCompanionHostingView(rootView: mainView)
        hostingView.frame = NSRect(origin: .zero, size: rect.size)
        hostingView.layer?.cornerRadius = 8
        hostingView.layer?.cornerCurve = .continuous
        hostingView.layer?.masksToBounds = true
        hostingView.translatesAutoresizingMaskIntoConstraints = false

        let visualEffect = NSVisualEffectView()
        visualEffect.blendingMode = .behindWindow
        visualEffect.state = .active
        visualEffect.material = .hudWindow
        contentView = visualEffect
        
        self.isMovableByWindowBackground = false

        self.contentView?.addSubview(hostingView)
    }

    deinit {
        print("CustomWindow DE-INIT")
    }

    override var canBecomeKey: Bool { false }
    override var canBecomeMain: Bool { false }

    func presentWindow() {
        orderFront(nil)
    }

    func hideWindow() {
        orderBack(nil)
    }
}

extension CustomWindow {
    func move(to frame: NSRect, duration: TimeInterval, completionBlock: (() -> Void?)? = nil) {
        if frame.origin == self.frame.origin ||
            self.frame.origin.distance(from: frame.origin) < 5 ||
            frame.origin.y < 0 {
            return
        }
        NSAnimationContext.current.timingFunction = CAMediaTimingFunction(controlPoints: 0.3, 0.16, 0.3, 1.1)

        NSAnimationContext.runAnimationGroup() { context in
            context.duration = 0.16
            self.animator().setFrame(frame, display: true, animate: true)
        } completionHandler: {
            completionBlock?()
        }
    }
}

class LoLCompanionHostingView<Content>: NSHostingView<Content> where Content: View {
    public override var allowsVibrancy: Bool { false }

    required public init(rootView: Content) {
        super.init(rootView: rootView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assert(false)
    }
}

