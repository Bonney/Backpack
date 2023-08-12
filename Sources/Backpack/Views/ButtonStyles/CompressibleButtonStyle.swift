//
//  CompressibleButtonStyle.swift
//
//  Created by Matt Bonney on 12/20/22.
//

import SwiftUI

/// A custom `ButtonStyle` that animates the button label when it is pressed.
/// The label is scaled down to `scale` when the button is pressed, and back to its original size when the button is released.
public struct CompressibleButtonStyle: ButtonStyle {
    // An animation that will be applied to the button when it is pressed or released.
    private let animation = Animation.interactiveSpring()
    
    // The scale factor to be applied to the button when it is pressed.
    private let scale: Double

    /// Initializes a new instance of `CompressibleButtonStyle` with the specified scale factor.
    ///
    /// - Parameters:
    ///   - scale: The scale factor to be applied to the button when it is pressed. The default value is 0.9.
    public init(scale: Double = 0.9) {
        self.scale = scale
    }

    /// Makes the body of a `Button` with the specified configuration.
    ///
    /// - Parameters:
    ///   - configuration: The configuration for the button.
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1.0)
            .animation(self.animation, value: configuration.isPressed)
    }
}

public extension ButtonStyle where Self == CompressibleButtonStyle {
    /// Returns a `CompressibleButtonStyle` with the specified scale factor.
    ///
    /// - Parameters:
    ///   - scale: The scale factor to be applied to the button when it is pressed.
    static func compressible(to scale: Double) -> Self {
        return .init(scale: scale)
    }
    
    /// Returns a `CompressibleButtonStyle` with the default scale factor (0.9).
    static var compressible: Self {
        return .init()
    }
}

/// A demo view that shows how to use the `CompressibleButtonStyle` in practice.
fileprivate struct CompressibleButtonStyleDemo: View {
    var body: some View {
        Button { } label: {
            Text("Tap me!")
                .foregroundStyle(.white)
                .padding()
                .background(Color.blue.gradient, in: Capsule())
        }
        .buttonStyle(.compressible(to: 0.9))
    }
}

/// A preview provider that provides previews of the `CompressibleButtonStyleDemo` view.
struct CompressibleButtonStyleDemo_Previews: PreviewProvider {
    static var previews: some View {
        CompressibleButtonStyleDemo()
    }
}
