//
//  LoLCompanionColors.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 24/01/2023.
//

import Foundation
import SwiftUI

enum LoLCompanionColors {
    case background, defeat, victory, gold, grey

    var nsColor: NSColor {
        switch self {
        case .background:
            return NSColor(red: 0.00, green: 0.04, blue: 0.07, alpha: 1.00)
        case .defeat:
            return NSColor(red: 0.96, green: 0.14, blue: 0.27, alpha: 1.00)
        case .victory:
            return NSColor(red: 0.05, green: 0.80, blue: 0.90, alpha: 1.00)
        case .gold:
            return NSColor(red: 0.82, green: 0.66, blue: 0.39, alpha: 1.00)
        case .grey:
            return NSColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        }
    }

    var swiftUI: Color {
        return Color(nsColor: self.nsColor)
    }
}
