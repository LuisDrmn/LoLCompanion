//
//  ProcessWatcher.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 21/01/2023.
//

import Foundation
import AppKit


class ProcessWatcher: ObservableObject {
    private static let lolWindowOwnerName: String = "League of Legends"
    private let companionWindowManager = CompanionWindowManager()

    private var watchForWindowTask: Task<(), Error>?

    @Published var lolProcesses = [LolProcesses : Bool]()

    init() {
        print("ProcessWatcher Started")
        watchForProcess()
    }

    private func watchForProcess() {
        Task(priority: .background) {
            repeat {
                let apps = NSWorkspace.shared.runningApplications
                for process in LolProcesses.allCases {
                    let appIsRunning = apps.contains(where: { $0.bundleIdentifier == process.bundleIdentifier })
                    if let app = lolProcesses[process], app == appIsRunning {
                        continue
                    }
                    print("\(process) is \(appIsRunning ? "Running" : "Not Running")")
                    DispatchQueue.main.async {
                        self.lolProcesses[process] = appIsRunning
                    }
                }

                if let leagueClientUx = lolProcesses[LolProcesses.leagueClientUx], leagueClientUx {
                    if let watchTaskIsCanceled = watchForWindowTask?.isCancelled, watchTaskIsCanceled {
                        watchForWindowTask = nil
                    }
                    await prepareWatchForWindowTask()
                    do {
                        let _ = watchForWindowTask
                    }

                } else {
                    if let watchForWindowTask = self.watchForWindowTask {
                        watchForWindowTask.cancel()
                    }
                }

                try await Task.sleep(for: .seconds(0.5))
            } while (!Task.isCancelled)
        }
    }
    
    private func prepareWatchForWindowTask() async {
        guard watchForWindowTask == nil else { return }

        watchForWindowTask = Task {
            repeat {
                let windowsList = CGWindowListCopyWindowInfo([.optionOnScreenOnly], CGWindowID(0)) as? [[String: AnyObject]]

                if let lolWindow = windowsList?.first(where: { $0[kCGWindowOwnerName as String] as? String ?? "" == ProcessWatcher.lolWindowOwnerName }) {
                    //        print(windowsList?.firstIndex(where: { $0[kCGWindowOwnerName as String] as? String ?? "" == "League of Legends" }))
                    let windowBounds = lolWindow[kCGWindowBounds as String] as? [String: Int]
                    let windowRect = NSRect(x: windowBounds?["X"] ?? 0, y: windowBounds?["Y"] ?? 0, width: windowBounds?["Width"] ?? 0, height: windowBounds?["Height"] ?? 0)
                    let newCompanionWindowRect = NSRect(origin: CGPoint(x: windowRect.maxX, y: ((windowRect.origin.y * -1) + windowRect.size.height)), size: CGSize(width: 200, height: windowRect.height))

                    DispatchQueue.main.async {
                        self.companionWindowManager.createWindow(with: newCompanionWindowRect)
                        self.companionWindowManager.updateWindow(to: newCompanionWindowRect.origin, height: newCompanionWindowRect.height)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.companionWindowManager.closeWindow()
                    }
                }
                try await Task.sleep(for: .milliseconds(100))
            } while (!Task.isCancelled)
        }
    }
}
