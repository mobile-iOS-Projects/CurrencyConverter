//
//  ImageView.swift
//  Conversion
//
//  Created by Siarhei Runovich on 25.06.24.
//

import SwiftUI

struct ImageView: View {
    var flagItem: FlagItem

    var body: some View {
        GeometryReader {
            let size = $0.size

            if let image = flagItem.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .clipped()
            }
        }
    }
}
