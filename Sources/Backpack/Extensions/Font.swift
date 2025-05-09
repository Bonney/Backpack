//
//  Font.swift
//  Wotter
//
//  Created by Matt Bonney on 2/3/21.
//

import SwiftUI

extension Font {
    public static func custom(style: Font.TextStyle, weight: Font.Weight, design: Font.Design) -> Font {
        Font.system(style, design: design).weight(weight)
    }

    public static func rounded(_ style: Font.TextStyle, weight: Font.Weight? = nil) -> Font {
        if let weight = weight {
            return Font.system(style, design: Design.rounded).weight(weight)
        } else {
            return Font.system(style, design: Design.rounded)
        }
    }

    public func alternative6and9() -> Font {
        self._stylisticAlternative(.one)
    }

    public func alternative4() -> Font {
        self._stylisticAlternative(.two)
    }
}
