//
//  LeadingVStack.swift
//  
//
//  Created by Matt Bonney on 11/15/22.
//

import SwiftUI

/// SwiftUI `VStack` with the `alignment` set to `.leading`.
public struct LeadingVStack<Content: View>: View {
    var spacing: CGFloat?
    var content: Content

    public init(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) {
        self.spacing = spacing
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            content
        }
    }
}

struct LeadingVStack_Previews: PreviewProvider {
    static var previews: some View {
        LeadingVStack {
            Text("LeadingVStack")
                .font(.title)
            Text("Default spacing.")
                .font(.callout)
        }
    }
}
