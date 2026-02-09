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
    let nodeSize: CGFloat = 300
    var body: some View {
        GeometryReader { outerGeo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(1..<20) { _ in
                        VStack {
                            GeometryReader { geo in
                                let centerX = outerGeo.size.width / 2
                                let itemCenterX = geo.frame(in: .global).midX
                                let distance = abs(itemCenterX - centerX)
                                let maxDistance = outerGeo.size.width / 2
                                let rotation = -Double(itemCenterX - centerX) / 8

                                // Keep full opacity in the central 80% of the screen
                                let fadeThreshold = maxDistance * 0.4
                                let opacity = distance < fadeThreshold ? 1.0 : max(0.1, 1.0 - (distance - fadeThreshold) / (maxDistance - fadeThreshold))

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
                    }
                }
                .padding(.horizontal, outerGeo.size.width / 2 - 100)
                .padding(.vertical, outerGeo.size.height / 2 - 100)
            }
        }
        .frame(width: 800, height: 800)
        .glassBackgroundEffect()
    }
}

#Preview {
    Concept004()
}
