//
//  SwiftUIView.swift
//  
//
//  Created by Matt Bonney on 2/11/23.
//

import SwiftUI

/// A custom button style that adds an outlined border to the button.
public struct OutlinedButtonStyle: ButtonStyle {

    /// The corner radius for the rounded rectangle
    private let cornerRadius: CGFloat

    /// Initializes a new instance of `OutlinedButtonStyle`
    /// - Parameters:
    ///   - cornerRadius: The corner radius for the rounded rectangle. Default value is 16.
    public init(cornerRadius: CGFloat = 16) {
        self.cornerRadius = cornerRadius
    }

    /// Applies the custom style to the button
    /// - Parameters:
    ///   - configuration: The `Configuration` instance to customize.
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundStyle(.tint)
            .background {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(.tint, lineWidth: 2)
            }
    }
}

public extension ButtonStyle where Self == OutlinedButtonStyle {

    /// A default instance of `OutlinedButtonStyle` with corner radius of 16
    static var outlined: Self {
        return .init()
    }

    /// Initializes a new instance of `OutlinedButtonStyle` with the specified corner radius
    /// - Parameters:
    ///   - cornerRadius: The corner radius for the rounded rectangle
    static func outlined(cornerRadius: CGFloat) -> Self {
        return .init(cornerRadius: cornerRadius)
    }
}

/// Previews for `OutlinedButtonStyle`
struct OutlinedButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Button("Blue") { }
                .tint(.blue)

            Button("Red") { }
                .tint(.red)

            Button("Green") { }
                .tint(.green)
        }
        .fontWeight(.medium)
        .buttonStyle(.outlined(cornerRadius: 16))
    }
}
