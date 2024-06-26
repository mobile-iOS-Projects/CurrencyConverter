//
//  FlagDetailView.swift
//  Conversion
//
//  Created by Siarhei Runovich on 25.06.24.
//

import SwiftUI
import CurrencyCoreUI

struct FlagDetailView: View {
    @Environment(UICoordinator.self) private var coordinator

    var body: some View {
        GeometryReader {
            let size = $0.size
            let animateView = coordinator.animateView
            let hideLayer = coordinator.hideLayer
            let rect = coordinator.rect

            /// This sets the anchorX location of the scaling , if the anchor is less than 0.5,
            /// it's on the leading side, Otherwise, i's on the trailing side.
            /// Keep in mind that view supprot animation for only two columns in a grid
            let anchorX = (coordinator.rect.minX / size.width) > 0.5 ? 1.0 : 0.0
            /// This value will be scaled to meet the screen's whole width
            let scale = size.width / coordinator.rect.width

            /// 15 - Horizontal Padding.
            let offsetX = animateView ? (anchorX > 0.5 ? 15 : -15) * scale : 0
            let offsetY = animateView ? -coordinator.rect.minY * scale : 0

            let detailHeight: CGFloat = rect.height * scale
            let scrollContentHeight: CGFloat = size.height - detailHeight

            if let image = coordinator.animationLayer, let flagItem = coordinator.selectedItem {
                if !hideLayer {
                    Image(uiImage: image)
                        .scaleEffect(animateView ? scale : 1, anchor: .init(x: anchorX, y: 0))
                        .offset(x: offsetX, y: offsetY)
                        .offset(y: animateView ? -coordinator.headerOffset : 0)
                        .opacity(animateView ? 0 : 1)
                        .transition(.identity)
                }

                ScrollView(.vertical) {
                    scrollContent()
                        .safeAreaInset(edge: .top, spacing: 0) {
                            Rectangle()
                                .fill(.clear)
                                .frame(height: detailHeight)
                                .offsetY { offset in
                                    coordinator.headerOffset = max(min(-offset, detailHeight), 0)
                                }
                        }
                }
                .scrollDisabled(!hideLayer)
                .contentMargins(.top, detailHeight, for: .scrollIndicators)
                .background {
                    Rectangle()
                        .fill(.background)
                        .padding(.top, scrollContentHeight)
                }
                .animation(.easeInOut(duration: 0.3).speed(1.5)) {
                    $0
                        .offset(y: animateView ? 0 : scrollContentHeight)
                        .opacity(animateView ? 1 : 0)
                }

                /// Hero Kinda View
                ImageView(flagItem: flagItem)
                    .allowsTightening(false)
                    .frame(
                        width: animateView ? size.width : rect.width,
                        height: animateView ? rect.height * scale : rect.height
                    )
                    .clipShape(.rect(cornerRadius: animateView ? 0 : 10))
                    .overlay(alignment: .top, content: {
                        headerActions(flagItem)
                            .offset(y: coordinator.headerOffset)
                            .padding(.top, safeArea.top)
                    })
                    .offset(x: animateView ? 0 : rect.minX, y: animateView ? 0 : rect.minY)
                    .offset(y: animateView ? -coordinator.headerOffset : 0)
            }
        }.ignoresSafeArea()
    }

    // Scroll Content
    @ViewBuilder
    func scrollContent() -> some View {
        DummyView()
    }

    // Header Actions
    @ViewBuilder
    func headerActions(_ item: FlagItem) -> some View {
        HStack {
            Spacer(minLength: 0)

            Button(action: {
                coordinator.toogleView(show: false, frame: .zero, item: item)
            }, label: {
               Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(Color.primary, .bar)
                    .padding(10)
                    .contentShape(.rect)
            })
        }
        .animation(.easeIn(duration: 0.3)) {
            $0
                .opacity(coordinator.hideLayer ? 1 : 0)
        }
    }
}

//#Preview {
//    FlagsView()
//}
