//
//  CGPoint+LoLCompanion.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 23/01/2023.
//

import Foundation

extension CGPoint {
    func distance(from point: CGPoint) -> CGFloat {
        let xDist = (point.x - self.x)
        let yDist = (point.y - self.y)
        let distance = sqrt((xDist * xDist) + (yDist * yDist))
        return distance
    }
}
