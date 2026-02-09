//  Step Into Vision - Example Code
//
//  Title: Concept004
//
//  Subtitle: Cover Flow
//
//  Description:
//
//  Type: Window Alt
//
//  Featured: true
//
//  Created by Joseph Simpson on 2/6/26.

import SwiftUI
import RealityKit
import RealityKitContent

struct Concept004: View {
    let nodeSize: CGFloat = 400
    private let itemSpacing: CGFloat = 16

    var body: some View {
        GeometryReader { outerGeo in
            let containerMidX = outerGeo.frame(in: .global).midX

            ScrollView(.horizontal, showsIndicators: false) {
                CoverFlowLayout(
                    itemSize: CGSize(width: nodeSize, height: nodeSize),
                    spacing: itemSpacing
                ) {
                    ForEach(1..<20) { _ in
                        CoverFlowItem(
                            nodeSize: nodeSize,
                            containerMidX: containerMidX
                        )
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, outerGeo.size.width / 2 - nodeSize / 2)
                .padding(.vertical, outerGeo.size.height / 2 - nodeSize / 2)
            }
            .scrollTargetBehavior(.viewAligned)
        }
        .frame(width: 800, height: 800)
        .glassBackgroundEffect()
    }
}

private struct CoverFlowLayout: Layout {
    let itemSize: CGSize
    let spacing: CGFloat

    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        guard !subviews.isEmpty else { return .zero }

        let count = CGFloat(subviews.count)
        let totalWidth = count * itemSize.width + max(0, count - 1) * spacing

        return CGSize(width: totalWidth, height: itemSize.height)
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        guard !subviews.isEmpty else { return }

        let itemProposal = ProposedViewSize(width: itemSize.width, height: itemSize.height)
        var nextX = bounds.minX + itemSize.width / 2

        for subview in subviews {
            subview.place(
                at: CGPoint(x: nextX, y: bounds.midY),
                anchor: .center,
                proposal: itemProposal
            )
            nextX += itemSize.width + spacing
        }
    }
}

private struct CoverFlowItem: View {
    let nodeSize: CGFloat
    let containerMidX: CGFloat

    var body: some View {
        GeometryReader { geo in
            let itemCenterX = geo.frame(in: .global).midX
            let distance = abs(itemCenterX - containerMidX)
            let maxDistance = max(1, containerMidX)
            let rotation = rotationAngle(for: itemCenterX)

            // Keep full opacity in the central 80% of the screen.
            let fadeThreshold = maxDistance * 0.4
            let opacity = distance < fadeThreshold
                ? 1.0
                : max(0.1, 1.0 - (distance - fadeThreshold) / (maxDistance - fadeThreshold))

            RoundedRectangle(cornerRadius: 24)
                .foregroundStyle(.black)
                .padding()
                .frame(width: nodeSize, height: nodeSize)
                .frame(depth: 40)
                .debugBorder3D(.white)
                .rotation3DLayout(.degrees(rotation), axis: .y)
                .shadow(radius: 24)
                .opacity(opacity)
                .offset(z: 60)
        }
        .frame(width: nodeSize, height: nodeSize)
    }

    private func rotationAngle(for itemCenterX: CGFloat) -> Double {
        let distance = itemCenterX - containerMidX
        let deadZone = nodeSize * 0.28

        if abs(distance) < deadZone {
            return 0
        }

        return -Double(distance) / 8
    }
}

#Preview {
    Concept004()
}
