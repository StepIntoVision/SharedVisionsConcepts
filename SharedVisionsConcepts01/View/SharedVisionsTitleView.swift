//
//  ContentView.swift
//  SharedVisionsConcepts01
//
//  Created by Joseph Simpson on 2/1/26.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct SharedVisionsTitleView: View {

    var body: some View {
        VStack(spacing: 12) {
            Text("Shared Visions")
                .font(.extraLargeTitle2)
            VStack {
                Text("An immersive story about the")
                Text("Apple Vision Pro Community")
            }
            .font(.caption)
            ToggleImmersiveSpaceButton()
        }
        .frame(width: 300)
        .padding()
        .glassBackgroundEffect(.feathered(padding: 120, softEdgeRadius: 8), in: .circle, displayMode: .always)
    }
}

#Preview(windowStyle: .automatic) {
    SharedVisionsTitleView()
        .environment(AppModel())
}
