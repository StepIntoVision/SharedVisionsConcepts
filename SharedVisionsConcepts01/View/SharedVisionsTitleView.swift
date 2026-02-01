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
                .font(.largeTitle)
            Text("An immersive documentary about the Apple Vision Pro community")
                .font(.caption)
            ToggleImmersiveSpaceButton()
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    SharedVisionsTitleView()
        .environment(AppModel())
}
