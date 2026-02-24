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
//  Featured: true
//
//  Created by Joseph Simpson on 2/23/26.

import SwiftUI
import RealityKit
import RealityKitContent

struct Concept009: View {

    var body: some View {
        RealityView { content in
            print("getting spheres")
            guard let uiSphere = try? await Entity(named: "UISphere01", in: realityKitContentBundle) else { return }
            guard let glassSphere = try? await Entity(named: "GlassSphere", in: realityKitContentBundle) else { return }
            content.add(uiSphere)
            content.add(glassSphere)
            glassSphere.position.y = 0.3
            print("getting spheres loaded")
        }

    }
}

#Preview {
    Concept009()
}
