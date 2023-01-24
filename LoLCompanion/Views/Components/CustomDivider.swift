//
//  CustomDivider.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 24/01/2023.
//

import SwiftUI

struct CustomDivider: View {
    var color: LoLCompanionColors
    var frame: NSSize

    var body: some View {
        Rectangle()
            .foregroundColor(color.swiftUI)
            .frame(width: frame.width, height: frame.height, alignment: .center)
    }
}

struct CustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider(color: .gold, frame: NSSize(width: 168, height: 1))
    }
}
