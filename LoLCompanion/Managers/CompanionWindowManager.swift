//
//  CompanionWindow.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 21/01/2023.
//

import Foundation
import AppKit

class CompanionWindowManager {
    var companionWindow: CustomWindow?

    init() {
        print("CompanionWindowManager INIT")
    }

    deinit {
        print("CompanionWindowManager DE-INIT")
    }

    func createWindow(with height: CGFloat) {
        guard companionWindow == nil else { return }
        print("FOUND LEAGUE OF LEGENDS WINDOW")
        print("CREATED COMPANION WINDOW")
        self.companionWindow = CustomWindow(with: height)
    }

    func closeWindow() {
        companionWindow?.close()
        self.companionWindow = nil
    }

    func updateWindow(to origin: CGPoint, height: CGFloat) {
        if self.companionWindow?.frame.origin == origin && self.companionWindow?.frame.height == height {
            return
        }
        self.companionWindow?.setFrame(NSRect(x: origin.x, y: origin.y, width: self.companionWindow?.frame.width ?? 0, height: height), display: true, animate: true)

        if NSWorkspace.shared.frontmostApplication?.bundleIdentifier == LolProcesses.leagueClientUx.bundleIdentifier {
            self.companionWindow?.orderFront(nil)
        } else {
            self.companionWindow?.orderBack(nil)
        }
    }

    func moveWindow(to origin: CGPoint) {
        self.companionWindow?.setFrameOrigin(origin)
    }
}

class CustomWindow: NSWindow {
    init(with height: CGFloat) {
        super.init(contentRect: NSRect(origin: .zero, size: CGSize(width: 200, height: height)), styleMask: [], backing: .buffered, defer: false)
        self.isReleasedWhenClosed = false
        self.orderBack(nil)
    }

    deinit {
        print("CustomWindow DE-INIT")
    }
}
