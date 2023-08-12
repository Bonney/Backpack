//
//  Color++.swift
//  Wotter
//
//  Created by Matt Bonney on 7/11/20.
//

import SwiftUI

public extension Color {
    init(hue: Double) {
        self.init(hue: hue, saturation: 1.0, brightness: 1.0)
    }

    init(hueOutOf360: Double) {
        self.init(hue: (hueOutOf360 / 360.0), saturation: 1.0, brightness: 1.0)
    }


    /// Returns a number of `Color`s by averaging HSL hues between start and end. Provides smoother color gradients that retain color rather than converging on gray. Looks like weather app temperature gradients!
    /// - Parameters:
    ///   - startHue: Hue for starting color, range 0.0 to 1.0.
    ///   - endHue: Hue for ending color, range 0.0 to 1.0.
    ///   - stops: How many color stops to return; default is 20.
    /// - Returns: An array of `Color`s.
    static func stops(startHue: Double, endHue: Double, stops: Int = 20, wrap: Bool = true) -> [Color] {
        // local references, to be edited if they're out of bounds
        var start: Double
        var end: Double

        if wrap {
            // if startHue is < 0, we wrap back around from one
            if startHue < 0 {
                start = 1.0 + startHue
            } else {
                start = startHue
            }

            // if endHue is > 1, we wrap back around from zero
            if endHue > 1 {
                end = endHue - 1.0
            } else {
                end = endHue
            }
        } else {
            start = startHue
            end = endHue
        }

        // hue distance between color stops for smoooooth gradients
        let step = (end - start) / Double(stops)

        // maps the steps to colors and returns an array
        return stride(from: start, to: end, by: step).map {
            Color(hue: $0)
        }

    }
}

struct Color_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            VStack {
                Text("Traditional")

                Text("0.0 to 0.5")

                Gauge(value: 0.5, in: 0...1) {
                    Text("1")
                }
                .gaugeStyle(.accessoryCircular)
                .tint(
                    LinearGradient(colors: [Color(hue: 0.0), Color(hue: 0.5)], startPoint: .leading, endPoint: .trailing)
                )

                LinearGradient(colors: [Color(hue: 0.0), Color(hue: 0.5)], startPoint: .top, endPoint: .bottom)
            }
            VStack {
                Text("Custom")

                Text("-0.2 to 1.25")

                Gauge(value: 0.5, in: 0...1) {
                    Text("2")
                }
                .gaugeStyle(.accessoryCircular)
                .tint(
                    LinearGradient(colors: Color.stops(startHue: -0.2, endHue: 1.25), startPoint: .leading, endPoint: .trailing)
                )

                LinearGradient(colors: Color.stops(startHue: -0.2, endHue: 1.25), startPoint: .top, endPoint: .bottom)
            }
        }
    }
}

public extension Color {
    static let aqua1 = Color(red: 59/255, green: 195/255, blue: 252/255)
    static let aqua2 = Color(red: 57/255, green: 146/255, blue: 251/255)

    static let brandLight = Color(red: 13/255, green: 198/255, blue: 255/255)
    static let brandDark = Color(red: 57/255, green: 123/255, blue: 242/255)

}

public extension Color {
    static let darkBlue = Color.with(r: 0, g: 0, b: 153)
    static let mediumBlue = Color.with(r: 0, g: 0, b: 204)
    static let lightBlue = Color.with(r: 0, g: 0, b: 255)

    static let health = Color(red: 255.0/255.0, green: 44.0/255.0, blue: 93.0/255.0)

    static func with(r: Double, g: Double, b: Double, a: Double = 1) -> Color {
        Color.init(
            red: r / 255.0,
            green: g / 255.0,
            blue: b / 255.0,
            opacity: a / 1.0
        )
    }
}

//#if canImport(UIKit)
//extension Color: RawRepresentable {
//
//    public init?(rawValue: String) {
//
//        guard let data = Data(base64Encoded: rawValue) else{
//            self = .black
//            return
//        }
//
//        do{
//            let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor ?? .black
//            self = Color(color)
//        }catch{
//            self = .black
//        }
//
//    }
//
//    public var rawValue: String {
//
//        do{
//            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
//            return data.base64EncodedString()
//
//        }catch{
//
//            return ""
//
//        }
//
//    }
//
//}
//#endif

