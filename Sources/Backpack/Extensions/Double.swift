//
//  Double++.swift
//  Wotter
//
//  Created by Matt Bonney on 7/4/20.
//

import SwiftUI

public extension Double {
    func toRadians() -> Double {
        return self * Double.pi / 180
    }

    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
}

public extension CGFloat {
    func rounded(to places: Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        let rounded = (self * divisor).rounded() / divisor
        return rounded
    }

    var trimmed: String {
        return Double(self).trimmed
    }
}

public extension Double {
    func rounded(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        let rounded = (self * divisor).rounded() / divisor
        return rounded
    }

    var trimmed: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

public extension Double {

    func formattedDecimalString(places: Int) -> String {
        let rounded = self.rounded(to: places)
        return rounded.removeTrailingZeroes()
    }

    func removeTrailingZeroes() -> String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

public extension Double {
    func removeZerosFromEnd(leaving x: Int = 1) -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = x //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
