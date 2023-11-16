//
//  SwiftUIView.swift
//  
//
//  Created by Matt Bonney on 11/4/23.
//

import SwiftUI

struct PreviewList<Content: View>: View {
    let repeatCount: Int
    @ViewBuilder let content: (Int) -> Content

    init(repeating: Int = 1, @ViewBuilder content: @escaping (Int) -> Content) {
        self.repeatCount = repeating
        self.content = content
    }

    var body: some View {
        List(1...repeatCount, id: \.self) { index in
            content(index)
        }
    }
}

#Preview {
    PreviewList(repeating: 2) { _ in
        Text("Hi!")
    }
}
