//
//  SharedVisionsConcepts01App.swift
//  SharedVisionsConcepts01
//
//  Created by Joseph Simpson on 2/1/26.
//

import SwiftUI

@main
struct SharedVisionsConcepts01App: App {

    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            MainWindowView()
                .glassBackgroundEffect(in: .circle, displayMode: .always)
                .environment(appModel)
        }
        // TODO: need to maintain square aspect ratio on resize
        .defaultSize(width: 800, height: 800)
        .windowStyle(.plain)

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.progressive), in: .progressive)
    }
}
