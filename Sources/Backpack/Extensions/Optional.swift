//
//  File.swift
//  
//
//  Created by Matt Bonney on 11/23/22.
//

import Swift

/// Extends the `Optional` type to add two computed properties for checking if a double is empty or has a value.
public extension Optional where Wrapped == Double {
    /// Returns a Boolean indicating if the wrapped double value is nil or equal to 0.0.
    var isEmpty: Bool {
        return (self == nil) || (self == 0.0)
    }

    /// Returns a Boolean indicating if the wrapped double value is not nil and not equal to 0.0.
    var hasValue: Bool {
        return !self.isEmpty
    }
}

