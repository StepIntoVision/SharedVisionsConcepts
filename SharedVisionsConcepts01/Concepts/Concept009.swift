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

    @State private var profileEntity = Entity()
    @State private var profile = "🧑🏻‍💻"

    var body: some View {
        RealityView { content in
            guard let glassSphere = try? await Entity(named: "GlassSphere", in: realityKitContentBundle) else { return }
            profileEntity = glassSphere
            content.add(glassSphere)

            if let attachmentAnchor = glassSphere.findEntity(named: "AttachmentAnchor") {
                let attachment = ViewAttachmentComponent(rootView: ProfileImage(imageTemp: $profile))
                attachmentAnchor.components.set(attachment)
            }



        }.toolbar {
            ToolbarItem(placement: .bottomOrnament, content: {
                HStack (spacing: 6 ) {
                    Button(action: {
                        print("🤔")
                        profile = "🤔"
                        changeLight()

                    }, label: {
                        Text("🤔")
                    })
                    Button(action: {
                        print("🧑🏻‍💻")
                        profile = "🧑🏻‍💻"
                        changeLight()

                    }, label: {
                        Text("🧑🏻‍💻")
                    })
                    Button(action: {
                        print("🐸")
                        profile = "🐸"
                        changeLight()


                    }, label: {
                        Text("🐸")
                    })
                }
            })
        }
        .controlSize(.large)

    }

    func changeLight() {
        if let light = profileEntity.findEntity(named: "PointLight") {

            var newLightColor : UIColor
            if(profile == "🧑🏻‍💻") {
                newLightColor = .blue

            } else if(profile == "🤔") {
                newLightColor = .orange

            } else {
                newLightColor = .cyan

            }
            light.components[PointLightComponent.self]?.color = newLightColor

        }
    }
}

fileprivate struct ProfileImage: View {
    @Binding var imageTemp: String
    var body: some View {
        Text(imageTemp)
            .font(.extraLargeTitle2)
    }
}


#Preview {
    Concept009()
}
