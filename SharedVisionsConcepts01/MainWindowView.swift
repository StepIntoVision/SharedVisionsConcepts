//
//  MainWindowView.swift
//  SharedVisionsConcepts01
//
//  Created by Joseph Simpson on 2/1/26.
//

import SwiftUI

struct MainWindowView: View {
    var body: some View {
        TabView {
            Tab("Shared Visions", systemImage: "circle.hexagongrid.fill") {
                Text("Shared Visions")
            }

            Tab("Library", systemImage: "circle.fill") {
                Text("Library")
            }

            Tab("Credits", systemImage: "ellipsis") {
                Text("About")
            }
        }
        
    }
}

#Preview {
    MainWindowView()
}
