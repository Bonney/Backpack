//
//  Squircle.swift
//  Wotter
//
//  Created by Matt Bonney on 1/21/21.
//

import SwiftUI

/// A struct that represents a custom shape, which is a combination of a square and a circle.
public struct Squircle: Shape {
    /// The ratio between the corner radius and the side length of the square.
    let ratio: CGFloat = 0.32

    /// Initializes a new `Squircle` shape.
    public init() {
    }

    /// Creates a path for the `Squircle` shape within the specified rectangle.
    public func path(in rect: CGRect) -> Path {
        var path = Path()

        /// The size of the rounded corners, which is determined based on the smaller dimension of the rectangle.
        let cornerSize: CGSize = {
            if rect.width > rect.height {
                return CGSize(width: rect.height * ratio, height: rect.height * ratio)
            } else {
                return CGSize(width: rect.width * ratio, height: rect.width * ratio)
            }
        }()

        /// Adds a rounded rectangle to the path, with the specified corner size and corner style.
        path.addRoundedRect(in: rect, cornerSize: cornerSize, style: .continuous)
        return path
    }
}

/// A struct for previewing the `Squircle` shape.
struct Squircle_Previews: PreviewProvider {
    static var previews: some View {

        /// Returns a `Squircle` shape with a blue foreground color and a frame size of 200x200.
        Squircle()
            .frame(width: 200, height: 200, alignment: .center)
            .foregroundStyle(.blue)

    }
}
