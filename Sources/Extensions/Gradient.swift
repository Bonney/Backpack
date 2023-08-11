//
//  LinearGradient++.swift
//  Wotter
//
//  Created by Matt Bonney on 7/11/20.
//

import SwiftUI

extension Gradient {
    static let aqua = Gradient(colors: [Color.aqua1, Color.aqua2])
    static let aquaReversed = Gradient(colors: [Color.aqua2, Color.aqua1])

    static let brand = Gradient(colors: [Color.brandLight, Color.brandDark])
    static let brandReversed = Gradient(colors: [Color.brandDark, Color.brandLight])
}

extension LinearGradient {
    static let aqua = LinearGradient(gradient: Gradient.aqua, startPoint: .top, endPoint: .bottom)
    static let aquaReversed = LinearGradient(gradient: Gradient.aquaReversed, startPoint: .top, endPoint: .bottom)

    static let brand = LinearGradient(gradient: Gradient.brand, startPoint: .top, endPoint: .bottom)
    static let brandReversed = LinearGradient(gradient: Gradient.brandReversed, startPoint: .top, endPoint: .bottom)
}

struct Gradient_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            LinearGradient(colors: [Color(hue: 0.0), Color(hue: 0.4)], startPoint: .top, endPoint: .bottom)
            LinearGradient(colors: Color.stops(startHue: 0.0, endHue: 0.4), startPoint: .top, endPoint: .bottom)
        }
    }
}
