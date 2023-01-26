//
//  LoLButton.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 26/01/2023.
//

import SwiftUI

struct LoLButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .buttonStyle(.plain)
            .foregroundColor(LoLCompanionColors.gold.swiftUI)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(LoLCompanionColors.background.swiftUI)
            .overlay(Rectangle().stroke(LoLCompanionColors.gold.swiftUI, lineWidth: 2))
    }
}
