//  Step Into Vision - Example Code
//
//  Title: Concept005
//
//  Subtitle: Horizontal Scroll
//
//  Description: A simple horizontally scrolling list of placeholder items in a window.
//
//  Type: Window
//
//  Featured: true
//
//  Created by Joseph Simpson on 2/9/26.

import SwiftUI

struct Concept005: View {
    private let itemCount = 20
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Horizontal Scroll Concept")
                .font(.largeTitle)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 20) {
                    ForEach(0..<itemCount, id: \.self) { index in
                        PlaceholderItem(index: index)
                    }
                }
                .padding(.horizontal, 40)
            }
        }
        .frame(width: 800, height: 600)
        .padding()
    }
}

private struct PlaceholderItem: View {
    let index: Int
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .foregroundStyle(.black)
            .frame(width: 200, height: 200)
    }
}

#Preview {
    Concept005()
}
