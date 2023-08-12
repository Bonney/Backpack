//
//  SwiftUIView.swift
//  
//
//  Created by Matt Bonney on 2/10/23.
//

import SwiftUI

/// Shorthand for .opacity(Bool ? 1 : 0).
public struct OpaqueModifier: ViewModifier {
    private let isOpaque: Bool

    public init(isOpaque: Bool) {
        self.isOpaque = isOpaque
    }

    public func body(content: Content) -> some View {
        content
            .opacity(isOpaque ? 1 : 0)
    }
}

public extension View {

    /// Sets a view's opacity to 1.0 or 0.0 based on Boolean input.
    func opaque(when isOpaque: Bool) -> some View {
        self.modifier(OpaqueModifier(isOpaque: isOpaque))
    }

    /// Sets a view's opacity to 1.0 or 0.0 when a Boolean equals a specific true/false value.
    func opaque(when value: Bool, equals comparison: Bool) -> some View {
        self.modifier(OpaqueModifier(isOpaque:  (value == comparison)))
    }

    /// Sets a view's opacity to 1.0 or 0.0 based on equivalence of two `Equatable` values.
    func opaque<T: Equatable>(when value: T, equals comparison: T) -> some View {
        self.modifier(OpaqueModifier(isOpaque:(value == comparison)))
    }
}

struct OpaqueModifier_Previews: PreviewProvider {
    struct Demo: View {
        @State private var visible: Bool = false

        @State private var x: Int = 2

        var body: some View {
            VStack {
                Button("Toggle") {
                    visible.toggle()
                }

                HStack {
                    Text("True.")
                        .opaque(when: visible)

                    Text("False.")
                        .opaque(when: visible, equals: false)
                }
                .font(.largeTitle)
                .padding()

                Divider()

                Stepper("X = \(x)", value: $x, in: 0...4, step: 1)

                Text("X = 4")
                    .font(.largeTitle)
                    .opaque(when: x, equals: 4)
            }
            .animation(.easeOut, value: visible)
            .padding()
        }
    }
    static var previews: some View {
        Demo()
    }
}
