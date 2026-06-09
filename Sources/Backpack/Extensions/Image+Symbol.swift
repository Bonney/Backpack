//
//  File.swift
//  
//
//  Created by Matt Bonney on 11/28/22.
//

import SwiftUI

public typealias SFSymbol = Image

/// Shorthand for initializing SF Symbols.
public extension SFSymbol {
    init(_ name: String) {
        self.init(systemName: name)
    }
}
