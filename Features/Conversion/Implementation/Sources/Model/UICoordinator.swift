//
//  UICoordinator.swift
//  Conversion
//
//  Created by Siarhei Runovich on 25.06.24.
//

import SwiftUI

@Observable
final class UICoordinator {
    /// Shared View Properties between Flags and FlagsDetails View
    var scrollView: UIScrollView = .init(frame: .zero)
    var rect: CGRect = .zero
    var selectedItem: FlagItem?
    /// Animatiom Layer Properties
    var animationLayer: UIImage?
    var animateView = false
    var hideLayer = false
    /// Root View Properties
    var hideRootView = false
    /// Flag Detail View Properties
    var headerOffset: CGFloat = .zero

    /// This will capture a screenshot of the scrollview's visible refion, not the complete scroll content
    func createVisibleAreaSnapshot() {
        let renderer = UIGraphicsImageRenderer(size: scrollView.bounds.size)
        let image = renderer.image { ctx in
            ctx.cgContext.translateBy(x: -scrollView.contentOffset.x, y: -scrollView.contentOffset.y)
            scrollView.layer.render(in: ctx.cgContext)
        }
        animationLayer = image
    }

    func toogleView(show: Bool, frame: CGRect, item: FlagItem) {
        if show {
            selectedItem = item
            /// Storing View's Rect
            rect = frame
            /// Generating ScrollView's Visible area Snaphots
            createVisibleAreaSnapshot()
            hideRootView = true
            withAnimation(.easeInOut(duration: 0.3), completionCriteria: .removed) {
                animateView = true
            } completion: {
                self.hideLayer = true
            }
        } else {
            /// Closing View
            hideLayer = false
            
            withAnimation(.easeInOut(duration: 0.3), completionCriteria: .removed) {
                animateView = false
            } completion: {
              /// Resetting Properties
                DispatchQueue.main.async {
                    self.resetAnimationProperties()
                }
            }
        }
    }
    
    private func resetAnimationProperties() {
        headerOffset = 0
        hideRootView = false
        rect = .zero
        selectedItem = nil
        animationLayer = nil
    }
}

/// This will extract the UIKit ScrollView from the SwiftUi ScrollView
struct ScrollViewExtractor: UIViewRepresentable {
    var result: (UIScrollView) -> ()
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        DispatchQueue.main.async {
            if let scrollView = view.superview?.superview?.superview as? UIScrollView {
                result(scrollView)
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
