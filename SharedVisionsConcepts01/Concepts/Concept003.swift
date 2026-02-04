//  Step Into Vision - Example Code
//
//  Title: Concept003
//
//  Subtitle: Spheres in a Circle
//
//  Description: Creates an immersive space with N spheres positioned in a circle around the user. The first sphere is placed in front of the user, then duplicated and arranged in a loop.
//
//  Type: Full Immersive Space
//
//  Featured: true
//
//  Created by Joseph Simpson on 2/4/26.

import SwiftUI
import RealityKit

struct Concept003: View {
    
    // Number of spheres to create
    let numberOfSpheres: Int = 8
    
    // Radius of the circle around the user (in meters)
    let circleRadius: Float = 2.0
    
    var body: some View {
        RealityView { content in
            
            // Create spheres positioned in a circle around the user
            for i in 0..<numberOfSpheres {
                
                // Calculate the angle for this sphere (in radians)
                let angle = Float(i) * (2.0 * .pi / Float(numberOfSpheres))
                
                // Calculate position using polar coordinates
                // X and Z form the circle around the user (Y-up coordinate system)
                let x = circleRadius * sin(angle)
                let z = -circleRadius * cos(angle) // Negative to place first sphere in front
                let y: Float = 1.5 // Eye level
                
                // Create a sphere mesh
                let sphereMesh = MeshResource.generateSphere(radius: 0.15)
                
                // Create a material with a color that varies based on position
                let hue = Double(i) / Double(numberOfSpheres)
                let color = UIColor(hue: hue, saturation: 0.8, brightness: 0.9, alpha: 1.0)
                var material = SimpleMaterial()
                material.color = .init(tint: color)
                material.metallic = .init(floatLiteral: 0.2)
                material.roughness = .init(floatLiteral: 0.3)
                
                // Create the entity
                let sphereEntity = ModelEntity(mesh: sphereMesh, materials: [material])
                
                // Set the position
                sphereEntity.position = SIMD3<Float>(x, y, z)
                
                // Add to the scene
                content.add(sphereEntity)
            }
            
            // Optional: Add a small marker sphere at the center (user position)
            let centerMesh = MeshResource.generateSphere(radius: 0.05)
            var centerMaterial = SimpleMaterial()
            centerMaterial.color = .init(tint: .white)
            let centerEntity = ModelEntity(mesh: centerMesh, materials: [centerMaterial])
            centerEntity.position = SIMD3<Float>(0, 1.5, 0)
            content.add(centerEntity)
        }
    }
}

#Preview {
    Concept003()
}
