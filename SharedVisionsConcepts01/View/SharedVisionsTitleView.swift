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
                .font(.extraLargeTitle)
            VStack {
                Text("An immersive story about the")
                Text("Apple Vision Pro Community")
            }
            .font(.caption)

            ToggleImmersiveSpaceButton()
                .offset(y: 30)
        }
        .frame(width: 320, height: 320)
        .glassBackgroundEffect(.automatic, in: .circle, displayMode: .always)
    }
}

#Preview(windowStyle: .automatic) {
    SharedVisionsTitleView()
        .environment(AppModel())
}
