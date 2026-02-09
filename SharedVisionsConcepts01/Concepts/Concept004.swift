//  Step Into Vision - Example Code
//
//  Title: Concept004
//
//  Subtitle: Cover Flow
//
//  Description: A horizontally scrolling cover flow layout using the Layout protocol and rotation3DLayout modifier for proper frame handling.
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
    let nodeSize: CGFloat = 200
    private let itemSpacing: CGFloat = 16
    private let containerWidth: CGFloat = 800
    private let containerHeight: CGFloat = 800

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            CoverFlowLayout(
                itemSize: CGSize(width: nodeSize, height: nodeSize),
                spacing: itemSpacing
            ) {
                ForEach(0..<20, id: \.self) { index in
                    CoverFlowItem(nodeSize: nodeSize, index: index)
                }
            }
            .scrollTargetLayout()
            .padding(.horizontal, containerWidth / 2 - nodeSize / 2)
            .padding(.vertical, containerHeight / 2 - nodeSize / 2)
        }
        .scrollTargetBehavior(.viewAligned)
        .frame(width: containerWidth, height: containerHeight)
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
    let index: Int
    @State private var rotation: Double = 0
    @State private var opacity: Double = 1

    var body: some View {
        RoundedRectangle(cornerRadius: 24)
            .foregroundStyle(.black)
            .padding()
            .frame(width: nodeSize, height: nodeSize)
            .frame(depth: 40)
            .debugBorder3D(.white)
            .shadow(radius: 24)
            .offset(z: 60)
            .rotation3DLayout(.degrees(rotation), axis: .y)
            .opacity(opacity)
            .onGeometryChange(for: CoverFlowGeometry.self) { geometryProxy in
                let frame = geometryProxy.frame(in: .scrollView)
                let scrollViewBounds = geometryProxy.bounds(of: .scrollView) ?? .zero
                let scrollViewMidX = scrollViewBounds.width / 2
                let itemCenterX = frame.midX
                let distance = itemCenterX - scrollViewMidX
                
                // Calculate rotation
                let deadZone = nodeSize * 0.28
                let calculatedRotation = abs(distance) < deadZone ? 0 : -Double(distance) / 8
                
                // Calculate opacity
                let maxDistance = scrollViewMidX
                let fadeThreshold = maxDistance * 0.4
                let absDistance = abs(distance)
                let calculatedOpacity = absDistance < fadeThreshold
                    ? 1.0
                    : max(0.1, 1.0 - (absDistance - fadeThreshold) / (maxDistance - fadeThreshold))
                
                return CoverFlowGeometry(rotation: calculatedRotation, opacity: calculatedOpacity)
            } action: { newValue in
                rotation = newValue.rotation
                opacity = newValue.opacity
            }
    }
}

private struct CoverFlowGeometry: Sendable {
    let rotation: Double
    let opacity: Double
}

extension CoverFlowGeometry: Equatable {
    nonisolated static func == (lhs: CoverFlowGeometry, rhs: CoverFlowGeometry) -> Bool {
        lhs.rotation == rhs.rotation && lhs.opacity == rhs.opacity
    }
}

#Preview {
    Concept004()
}
