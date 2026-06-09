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
    @available(*, deprecated, message: "Treats 0 as missing, which is rarely what you want. Check `== nil` or `?? 0 == 0` explicitly at the call site.")
    var isEmpty: Bool {
        return (self == nil) || (self == 0.0)
    }

    /// Returns a Boolean indicating if the wrapped double value is not nil and not equal to 0.0.
    @available(*, deprecated, message: "Treats 0 as missing, which is rarely what you want. Check `!= nil && self != 0` explicitly at the call site.")
    var hasValue: Bool {
        return (self != nil) && (self != 0.0)
    }
}

