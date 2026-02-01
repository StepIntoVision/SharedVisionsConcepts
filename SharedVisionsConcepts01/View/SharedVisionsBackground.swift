//
//  SharedVisionsBackground.swift
//  SharedVisionsConcepts01
//
//  Created by Joseph Simpson on 2/1/26.
//

import SwiftUI

struct SharedVisionsBackground: View {
    var body: some View {
        HoneycombLayout {
            ForEach(0..<72, id: \.self) { index in
                ZStack {
                    Circle()
                        .fill(.thickMaterial)
                        .frame(width: 80, height: 80)
                    Image(systemName: "person.fill")
                        .foregroundStyle(.secondary)
                        .font(.largeTitle)

                }
                .padding(12)
            }
        }
    }
}

#Preview {
    SharedVisionsBackground()
}
