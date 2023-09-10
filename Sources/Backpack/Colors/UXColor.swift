import SwiftUI

#if canImport(AppKit) //os(macOS)
import AppKit
public typealias UXColor = NSColor
#else
import UIKit
public typealias UXColor = UIColor
#endif

public extension UXColor {
    /// Determines if the color is bright or dark based on its overall luminance.
    /// - Returns: `true` if the color is bright, `false` if it is dark.
    func isBright(luminanceTolerance: CGFloat = 0.555) -> Bool {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let luminance = (0.2126 * red) + (0.7152 * green) + (0.0722 * blue)
        return luminance > luminanceTolerance // adjusts the "tolerance" of what is considered bright
    }
}

public extension UXColor {
    var hue: CGFloat {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return h
    }

    var hsb: (CGFloat, CGFloat, CGFloat) {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h, s, b)
    }
}

//extension UIColor {
//    var hue: CGFloat {
//        var hue: CGFloat = 0.0
//        var saturation: CGFloat = 0.0
//        var brightness: CGFloat = 0.0
//        var alpha: CGFloat = 0.0
//        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
//        return hue
//    }
//}

public extension SwiftUI.Color {
    func isBright(luminanceTolerance: CGFloat = 0.55) -> Bool {
        return UXColor(self).isBright(luminanceTolerance: luminanceTolerance)
    }

    // Return a contrasting color with default tolerance
    var contrastingForegroundColor: Color {
        self.contrastingForegroundColor()
    }

    func contrastingForegroundColor(luminanceTolerance: CGFloat = 0.55) -> Color {
        self.isBright(luminanceTolerance: luminanceTolerance) ? Color.black : Color.white
    }

    var hue: CGFloat {
        return UXColor(self).hue
    }

    var hsb: (CGFloat, CGFloat, CGFloat) {
        return UXColor(self).hsb
    }
}

// MARK: - Previews

struct ColorView: View {
    let color: Color

    var body: some View {
        ZStack {

            self.color
                .frame(height: 80)

            Text(color.isBright() ? "Bright" : "Dark")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(color.contrastingForegroundColor())
        }
    }
}

struct ColorView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(LabeledColor.gemstones) { labeledColor in
                    ColorView(color: labeledColor.color)
                }
            }
        }
    }
}
