//
//  HoneycombLayout.swift
//  SharedVisionsConcepts01
//
//  Created by Joseph Simpson on 2/1/26.
//

import SwiftUI

// Honeycomb grid layout that grows from the inside out
// Adapted from Step Into Vision labs
struct HoneycombLayout: Layout, Animatable {
    var angleOffset: Angle = .zero

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let updatedProposal = proposal.replacingUnspecifiedDimensions()
        let minDim = min(updatedProposal.width, updatedProposal.height)
        return CGSize(width: minDim, height: minDim)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }

        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let hexSize: CGFloat = 50
        let hexRadius = hexSize / 2

        // Calculate hexagon spacing (distance between centers)
        let hexSpacing = hexRadius * sqrt(3) + 20

        // Generate hexagon positions in a spiral pattern
        var positions: [CGPoint] = []
        positions.append(center) // Center hexagon

        var ring = 1
        while positions.count < subviews.count {
            // For each ring, place hexagons at 60-degree intervals
            for i in 0..<6 {
                let angle = Double(i) * .pi / 3 + angleOffset.radians
                let radius = Double(ring) * hexSpacing
                let x = center.x + radius * cos(angle)
                let y = center.y + radius * sin(angle)
                positions.append(CGPoint(x: x, y: y))
            }

            // Fill in the gaps between the corners for larger rings
            if ring > 1 {
                for i in 0..<6 {
                    let startAngle = Double(i) * .pi / 3 + angleOffset.radians
                    let endAngle = Double(i + 1) * .pi / 3 + angleOffset.radians
                    let radius = Double(ring) * hexSpacing

                    // Add intermediate positions with adjusted radius for tighter honeycomb
                    for j in 1..<ring {
                        let angle = startAngle + (endAngle - startAngle) * Double(j) / Double(ring)

                        // Adjust radius for items that should be closer to center
                        // Items at the edges of each segment get pulled in slightly
                        let radiusAdjustment = 0.15 // Pull items in by 15%
                        let adjustedRadius = radius * (1.0 - radiusAdjustment)

                        let x = center.x + adjustedRadius * cos(angle)
                        let y = center.y + adjustedRadius * sin(angle)
                        positions.append(CGPoint(x: x, y: y))
                    }
                }
            }

            ring += 1
        }

        // Place subviews at calculated positions
        for (index, subview) in subviews.enumerated() {
            if index < positions.count {
                subview.place(
                    at: positions[index],
                    anchor: .center,
                    proposal: .init(width: hexSize, height: hexSize)
                )
            }
        }
    }

    var animatableData: Angle.AnimatableData {
        get { angleOffset.animatableData }
        set { angleOffset.animatableData = newValue }
    }
}

