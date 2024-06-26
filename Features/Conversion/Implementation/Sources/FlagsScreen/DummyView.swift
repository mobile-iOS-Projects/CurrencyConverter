//
//  DummyView.swift
//  Conversion
//
//  Created by Siarhei Runovich on 25.06.24.
//

import SwiftUI

struct DummyView: View {
    var body: some View {
        LazyVStack(spacing: 15) {
            dummySection(title: "Social Media")
            
            dummySection(title: "Social Media", isLong: true)
            
            imageView(.eur)
            
            dummySection(title: "Buisness")
            
            dummySection(title: "Promotion Media", isLong: true)
            
            imageView(.pol)
            
            dummySection(title: "Youtube")
            
            dummySection(title: "Twitter", isLong: true)
            
        }.padding(15)
    }
}

extension DummyView {
    @ViewBuilder
    func dummySection(title: String, isLong: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 8, content: {
           Text(title)
                .font(.title.bold())
            
            Text("In the previous chapters, you got to use existing SwiftUI controls, like Image, Button or various stacks, to build an animated component. In many cases, if not the majority, they’re sufficient to make an app engaging and valuable. But what about a non-trivial view requiring more intricate user interaction? \(isLong ? "Avid basketball fans often have specific preferences regarding their seating. It’s not enough to choose how many tickets they need for a game and have their credit card charged. They also want to choose where their seats are." : "")")
                .multilineTextAlignment(.leading)
                .kerning(1.2)
                
            
        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func imageView(_ image: ImageResource) -> some View {
        GeometryReader {
            let size = $0.size
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipped()
        }.frame(height: 400)
    }
}

#Preview {
    DummyView()
}
