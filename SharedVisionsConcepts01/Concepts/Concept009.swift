//  Shared Visions Concepts
//
//  Title: Concept009
//
//  Subtitle: Small Sphere Volume
//
//  Description: A minimal volume with a single small sphere.
//
//  Type: Volume
//
//  Featured: false
//
//  Created by Joseph Simpson on 2/23/26.

import SwiftUI
import RealityKit
import RealityKitContent

struct Concept009: View {
    var body: some View {
        RealityView { content in
            let sphere = ModelEntity(
                mesh: .generateSphere(radius: 0.03),
                materials: [SimpleMaterial(color: .white, isMetallic: false)]
            )
            sphere.position = [0, 0, 0]
            content.add(sphere)
        }
        .frame(width: 300, height: 300)
        .frame(depth: 300)
    }
}

#Preview {
    Concept009()
}
