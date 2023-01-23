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
        let windowsList = CGWindowListCopyWindowInfo([.optionOnScreenAboveWindow], CGWindowID(0)) as? [[String: AnyObject]]

        guard let lolWindow = windowsList?.first(where: { $0[kCGWindowOwnerName as String] as? String ?? "" == "League of Legends" }) else { return }
        print(windowsList?.firstIndex(where: { $0[kCGWindowOwnerName as String] as? String ?? "" == "League of Legends" }))
        let windowBounds = lolWindow[kCGWindowBounds as String] as? [String: Int]
        let windowRect = NSRect(x: windowBounds?["X"] ?? 0, y: windowBounds?["Y"] ?? 0, width: windowBounds?["Width"] ?? 0, height: windowBounds?["Height"] ?? 0)
        let newCompanionWindowRect = NSRect(origin: CGPoint(x: windowRect.maxX, y: ((windowRect.origin.y * -1) + windowRect.size.height)), size: CGSize(width: 200, height: windowRect.height))
        
        DispatchQueue.main.async {
            self.companionWindowManager.createWindow(with: newCompanionWindowRect)
            self.companionWindowManager.updateWindow(to: newCompanionWindowRect.origin, height: newCompanionWindowRect.height)
        }

        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + .milliseconds(100)) {
            self.watchForWindow()
        }
    }
}
