//
//  IntSlider.swift
//  
//
//  Created by Matt Bonney on 11/26/22.
//

import SwiftUI

/// Riff on a SwiftUI `Slider` that binds and snaps to Int values.
public struct IntSlider<Label: View>: View {
    @Binding var value: Int
    let range: ClosedRange<Int>
    let label: () -> Label

    public init(value: Binding<Int>, in range: ClosedRange<Int>, @ViewBuilder label: @escaping () -> Label) {
        self._value = value
        self.range = range
        self.label = label
    }

    private var convertedRange: ClosedRange<Double> {
        Double(range.lowerBound)...Double(range.upperBound)
    }

    public var body: some View {
        Slider(
            value:
                Binding<Double>(
                    get: {
                        Double(value)
                    },
                    set: { newValue in
                        value = Int(newValue)
                    }
                ),
            in: convertedRange) {
                label()
            }
    }
}


struct IntArraySlider: View {
    let arr: [Int]
    @Binding var currentIndex: Int
    var body: some View {
        let b = Binding<Double>(
            get: { Double(arr[currentIndex]) },
            set: { d in
                let i = Int(floor(d))
                if let index = arr.lastIndex(where: { $0 <= i }) {
                    currentIndex = index
                }
            }
        )
        let r = Double(arr.first ?? 0)...Double(arr.last ?? 0)
        Slider(value: b, in: r)
    }
}


fileprivate struct IntSlider_PreviewHost: View {
    @State private var currentIndex = 0
    let range = 0...7

    var body: some View {
        VStack {
            Text("current: \(currentIndex)")
            Text("possible: \(range.map({ String($0) }).formatted(.list(type: .and)))")
            IntSlider(value: $currentIndex, in: range) {
                Text("Slider label.")
            }
        }
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
       IntSlider_PreviewHost()
    }
}
