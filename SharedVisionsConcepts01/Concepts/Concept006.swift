//  Shared Visions Concepts
//
//  Title: Concept006
//
//  Subtitle: Radial Ring
//
//  Description: A volumetric ring of emoji spheres using RadialLayout with rotation controls and Z-axis offset animation for depth effects.
//
//  Type: Volume
//
//  Featured: true
//
//  Created by Joseph Simpson on 2/9/26.

import SwiftUI
import RealityKit
import RealityKitContent

struct Concept006: View {
    
    @State private var showDebugLines = false
    @State private var layoutRotation: Double = 45
    @State private var angleOffset: Angle = .zero
    @State private var offsetZ: CGFloat = 0
    @State private var isAnimatingOffsetZ: Bool = false
    @State private var animationTimerOffsetZ: Timer?
    @State private var offsetZDirection: Bool = true
    
    let emoji: [String] = ["🌸", "🐸", "❤️", "🔥", "💻", "🐶", "🥸", "📱", "🎉", "🚀", "🤔"]
    
    var body: some View {
        VStack {
            RadialLayout(angleOffset: angleOffset) {
                ForEach(0..<11, id: \.self) { index in
                    ModelViewEmoji(name: "UISphere01", emoji: emoji[index], bundle: realityKitContentBundle)
                        .rotation3DLayout(Rotation3D(angle: .degrees(360 - layoutRotation), axis: .x))
                        .offset(z: offsetZ * CGFloat(index))
                }
            }
            .rotation3DLayout(Rotation3D(angle: .degrees(layoutRotation), axis: .x))
            .frame(width: 300, height: 300)
            .debugBorder3D(showDebugLines ? .white : .clear)
        }
        .frame(width: 800, height: 800)
        .ornament(attachmentAnchor: .scene(.trailing), ornament: {
            VStack(alignment: .leading, spacing: 8) {
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        layoutRotation = layoutRotation == 45 ? 0 : 45
                    }
                }, label: {
                    Label("Rotate Layout", systemImage: "arrow.triangle.2.circlepath")
                })
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        angleOffset += .degrees(30)
                    }
                }, label: {
                    Label("Shift Angle", systemImage: "arrow.clockwise")
                })
                
                Button(action: {
                    if isAnimatingOffsetZ {
                        animationTimerOffsetZ?.invalidate()
                        animationTimerOffsetZ = nil
                        isAnimatingOffsetZ = false
                        withAnimation(.easeInOut(duration: 0.5)) {
                            offsetZ = 0
                        }
                    } else {
                        isAnimatingOffsetZ = true
                        animationTimerOffsetZ = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                            withAnimation(.linear(duration: 0.05)) {
                                if offsetZDirection {
                                    offsetZ += 0.5
                                    if offsetZ >= 30.0 {
                                        offsetZDirection = false
                                    }
                                } else {
                                    offsetZ -= 0.5
                                    if offsetZ <= 0 {
                                        offsetZDirection = true
                                    }
                                }
                            }
                        }
                    }
                }, label: {
                    Label("Z Offset", systemImage: isAnimatingOffsetZ ? "stop" : "play")
                })
                
                Button(action: {
                    showDebugLines.toggle()
                }, label: {
                    Text("Debug")
                })
            }
            .padding()
            .controlSize(.small)
            .glassBackgroundEffect()
        })
    }
}

#Preview {
    Concept006()
}

// MARK: - Supporting Views

fileprivate struct ModelViewEmoji: View {
    
    let name: String
    let emoji: String
    let bundle: Bundle
    
    var body: some View {
        Model3D(named: name, bundle: bundle) { phase in
            if let model = phase.model {
                model
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .spatialOverlay(alignment: .center) {
                        Text(emoji)
                            .font(.system(size: 30))
                    }
            } else if phase.error != nil {
                Text(emoji)
            } else {
                ProgressView()
            }
        }
    }
}
