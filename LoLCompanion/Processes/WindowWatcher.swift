//
//  ProcessWatcher.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 21/01/2023.
//

import Foundation
import AppKit

class ProcessWatcher: ObservableObject {
    var companionWindowManager = CompanionWindowManager()

    init() {
        watchForWindow()
    }

    func isRunning(process: LolProcesses) -> Bool {
        let apps = NSWorkspace.shared.runningApplications
        for app in apps {
            if app.bundleIdentifier == process.bundleIdentifier {
                print("FOUND \(app.bundleIdentifier ?? "") with PID: \(app.processIdentifier)")
                return true
            }
        }
        print("DIDN'T FOUND: \(process.name)")
        return false
    }

    private func watchForWindow() {
        let windowsList = CGWindowListCopyWindowInfo([.optionOnScreenOnly], CGWindowID(0)) as? [[String: AnyObject]]
        for window in (windowsList ?? []) {
            if window[kCGWindowOwnerName as String] as? String ?? "" == "League of Legends" {
                let windowBounds = window[kCGWindowBounds as String] as? [String: Int]
                let windowRect = NSRect(x: windowBounds?["X"] ?? 0, y: windowBounds?["Y"] ?? 0, width: windowBounds?["Width"] ?? 0, height: windowBounds?["Height"] ?? 0)
                DispatchQueue.main.async {
                    self.companionWindowManager.createWindow(with: windowRect.height)
                }
                if let window = self.companionWindowManager.companionWindow {
                    DispatchQueue.main.async {
                        let newOrigin = CGPoint(x: windowRect.maxX, y: ((windowRect.origin.y * -1) + windowRect.size.height * 2 - window.frame.height))
                        self.companionWindowManager.updateWindow(to: newOrigin, height: windowRect.height)
                    }
                }
            }
        }

        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .milliseconds(250)) {
            self.watchForWindow()
        }
    }
}
