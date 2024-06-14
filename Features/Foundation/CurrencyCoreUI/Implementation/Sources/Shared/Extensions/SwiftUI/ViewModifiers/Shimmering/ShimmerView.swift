//
//  ShimmerView.swift
//  SMSCoreUI
//
//  Created by Steinmetz, Conrad on 03.02.23.
//

import SwiftUI

// Credit: https://github.com/markiv/SwiftUI-Shimmer (1.4.0)
// Credit is referenced in `../SMSCore/Implementation/Resources/oss_licenses/config.yml`

/// A view modifier that applies an animated "shimmer" to any view, typically to show that an operation is in progress.
@available(watchOS 10, *)
public struct Shimmer_v4: ViewModifier {
    private let animation: Animation
    private let gradient: Gradient
    private let min, max: CGFloat
    @State private var isInitialState = true
    @Environment(\.layoutDirection) private var layoutDirection

    /// Initializes his modifier with a custom animation,
    /// - Parameters:
    ///   - animation: A custom animation. Defaults to ``Shimmer/defaultAnimation``.
    ///   - gradient: A custom gradient. Defaults to ``Shimmer/defaultGradient``.
    ///   - bandSize: The size of the animated mask's "band". Defaults to 0.3 unit points, which corresponds to
    /// 30% of the extent of the gradient.
    public init(
        animation: Animation = Self.defaultAnimation,
        gradient: Gradient = Self.defaultGradient,
        bandSize: CGFloat = 0.3
    ) {
        self.animation = animation
        self.gradient = gradient
        // Calculate unit point dimensions beyond the gradient's edges by the band size
        self.min = 0 - bandSize
        self.max = 1 + bandSize
    }

    /// The default animation effect.
    public static let defaultAnimation = Animation.linear(duration: 1.5).delay(0.25).repeatForever(autoreverses: false)

    #if os(iOS)
    // A default gradient for the animated mask.
    public static let defaultGradient = Gradient(colors: [
        Color.black.opacity(0.4),
        Color.black.opacity(0.9),
        Color.black.opacity(0.4),
    ])
    #endif

    #if os(watchOS)
    // A default gradient for the animated mask.
    public static let defaultGradient = Gradient(colors: [
        Color.black.opacity(0.14),
        Color.black.opacity(0.2),
        Color.black.opacity(0.14),
    ])
    #endif

    #if os(visionOS)
    // A default gradient for the animated mask.
    public static let defaultGradient = Gradient(colors: [
        Color.white.opacity(0.14),
        Color.white.opacity(0.2),
        Color.white.opacity(0.14),
    ])
    #endif

    /// The default band size
    public static var defaultBandSize: CGFloat = 0.3

    /*
     Calculating the gradient's animated start and end unit points:
     min,min
        \
         ┌───────┐         ┌───────┐
         │0,0    │ Animate │       │  "forward" gradient
     LTR │       │ ───────►│    1,1│  / // /
         └───────┘         └───────┘
                                    \
                                  max,max
                max,min
                  /
         ┌───────┐         ┌───────┐
         │    1,0│ Animate │       │  "backward" gradient
     RTL │       │ ───────►│0,1    │  \ \\ \
         └───────┘         └───────┘
                          /
                       min,max
     */

    /// The start unit point of our gradient, adjusting for layout direction.
    var startPoint: UnitPoint {
        if layoutDirection == .rightToLeft {
            return isInitialState ? UnitPoint(x: max, y: min) : UnitPoint(x: 0, y: 1)
        } else {
            return isInitialState ? UnitPoint(x: min, y: min) : UnitPoint(x: 1, y: 1)
        }
    }

    /// The end unit point of our gradient, adjusting for layout direction.
    var endPoint: UnitPoint {
        if layoutDirection == .rightToLeft {
            return isInitialState ? UnitPoint(x: 1, y: 0) : UnitPoint(x: min, y: max)
        } else {
            return isInitialState ? UnitPoint(x: 0, y: 0) : UnitPoint(x: max, y: max)
        }
    }

    public func body(content: Content) -> some View {
        content
            .animation(nil, value: false) // Prevent animation from propagating to the modified view
            .mask(LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint))
            .animation(animation, value: isInitialState)
            .onAppear {
                // Delay the animation until the initial layout is established
                // to prevent animating the appearance of the view
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    isInitialState = false
                }
            }
    }
}

extension View {
    /// Adds an animated shimmering effect to any view, typically to show that an operation is in progress.
    /// - Parameters:
    ///   - active: Convenience parameter to conditionally enable the effect. Defaults to `true`.
    ///   - animation: A custom animation. Defaults to ``Shimmer/defaultAnimation``.
    ///   - gradient: A custom gradient. Defaults to ``Shimmer/defaultGradient``.
    ///   - bandSize: The size of the animated mask's "band". Defaults to 0.3 unit points, which corresponds to
    /// 20% of the extent of the gradient.
    @ViewBuilder public func shimmering(
        active: Bool = true
    ) -> some View {
        if active {
            #if !os(visionOS)
                self.modifier(Shimmer_v4(
                    animation: Shimmer_v4.defaultAnimation,
                    gradient: Shimmer_v4.defaultGradient,
                    bandSize: Shimmer_v4.defaultBandSize
                ))
            #else
            self.modifier(Shimmer_v4(
                animation: Shimmer_v4.defaultAnimation,
                gradient: Shimmer_v4.defaultGradient,
                bandSize: Shimmer_v4.defaultBandSize
            ))
            #endif
        } else {
            self
        }
    }
}

struct Shimmer_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Rectangle().frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            VStack {
                Text("Hello World")
                    .font(.title)
                
                Text("Hello World")
            }
        }
//            .foregroundColor(.preferredSMSColor(for: .primaryLabel))
        .redacted(reason: .placeholder)
            .shimmering(active: false)
            .previewLayout(.sizeThatFits)
    }
}
