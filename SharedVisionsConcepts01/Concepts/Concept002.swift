//  Step Into Vision - Example Code
//
//  Title: Concept002
//
//  Subtitle: Spheres in a Volume
//
//  Description: Just an example scene in a Volume
//
//  Type: Volume
//
//  Featured: false
//
//  Created by Joseph Simpson on 2/4/26.

import SwiftUI
import RealityKit
import RealityKitContent

struct Concept002: View {
    var body: some View {
        RealityView { content in
            // Create a pivot entity at the center
            let pivot = Entity()
            pivot.name = "pivot"
            pivot.position = [0, 0, 0]
            content.add(pivot)
            
            // Create three spheres
            let sphere1 = ModelEntity(
                mesh: .generateSphere(radius: 0.05),
                materials: [SimpleMaterial(color: .black, isMetallic: false)]
            )
            sphere1.position = [0.25, 0, 0]

            let sphere2 = ModelEntity(
                mesh: .generateSphere(radius: 0.05),
                materials: [SimpleMaterial(color: .black, isMetallic: false)]
            )
            sphere2.position = [-0.075, 0, 0.13]
            
            let sphere3 = ModelEntity(
                mesh: .generateSphere(radius: 0.05),
                materials: [SimpleMaterial(color: .black, isMetallic: false)]
            )
            sphere3.position = [-0.075, 0, -0.13]
            
            content.add(sphere1)
            content.add(sphere2)
            content.add(sphere3)
            
            // Create an action entity resolution to the pivot entity
            let pivotEntity: ActionEntityResolution = .entityNamed("pivot")
            
            // Create orbit actions for each sphere
            let action1 = OrbitEntityAction(
                pivotEntity: pivotEntity,
                revolutions: 1,
                orbitalAxis: [0.25, 1, 0],
                isOrientedToPath: false,
                isAdditive: false
            )
            let animation1 = try! AnimationResource.makeActionAnimation(for: action1, duration: 8.0, bindTarget: .transform)
            sphere1.playAnimation(animation1.repeat())
            
            let action2 = OrbitEntityAction(
                pivotEntity: pivotEntity,
                revolutions: 1,
                orbitalAxis: [0, 1, -6],
                isOrientedToPath: false,
                isAdditive: false
            )
            let animation2 = try! AnimationResource.makeActionAnimation(for: action2, duration: 8.0, bindTarget: .transform)
            sphere2.playAnimation(animation2.repeat())
            
            let action3 = OrbitEntityAction(
                pivotEntity: pivotEntity,
                revolutions: 1,
                orbitalAxis: [0, 1, 0],
                isOrientedToPath: false,
                isAdditive: false
            )
            let animation3 = try! AnimationResource.makeActionAnimation(for: action3, duration: 8.0, bindTarget: .transform)
            sphere3.playAnimation(animation3.repeat())
        }
        .frame(width: 800, height: 800)
        .debugBorder3D(.white)

    }
}

#Preview {
    Concept002()
}
