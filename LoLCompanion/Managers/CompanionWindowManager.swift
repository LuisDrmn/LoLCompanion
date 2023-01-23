//
//  CompanionWindow.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 21/01/2023.
//

import Foundation
import AppKit
import SwiftUI

class CompanionWindowManager {
    var companionWindow: CustomWindow?

    init() {
        print("CompanionWindowManager Init")
    }

    deinit {
        print("CompanionWindowManager DE-INIT")
    }

    func createWindow(with rect: NSRect) {
        guard companionWindow == nil else { return }
        print("FOUND LEAGUE OF LEGENDS WINDOW")
        print("CREATED COMPANION WINDOW")
        self.companionWindow = CustomWindow(with: rect)
    }

    func closeWindow() {
        companionWindow?.close()
        self.companionWindow = nil
    }

    func updateWindow(to origin: CGPoint, height: CGFloat) {
        guard let companionWindow = self.companionWindow else { return }

        print(NSWorkspace.shared.frontmostApplication)
        if NSWorkspace.shared.frontmostApplication?.bundleIdentifier == LolProcesses.leagueClientUx.bundleIdentifier {
            companionWindow.presentWindow()
        } else {
            companionWindow.hideWindow()
            return
        }

        let newFrame = NSRect(x: origin.x, y: origin.y, width: companionWindow.frame.width, height: height)
        companionWindow.move(to: newFrame, duration: 0.3)

    }
}

