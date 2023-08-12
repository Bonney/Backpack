import SwiftUI

extension UnitPoint {
    /// Returns the opposite `UnitPoint` value based on the current.
    /// For example: `UnitPoint.top.opposite` returns `UnitPoint.bottom`.
    public var opposite: UnitPoint {
        switch self {
            case .leading: return .trailing
            case .trailing: return .leading

            case .top: return .bottom
            case .topLeading: return .bottomTrailing
            case .topTrailing: return .bottomLeading

            case .bottom: return .top
            case .bottomLeading: return .topTrailing
            case .bottomTrailing: return .bottomLeading

            default: return .center
        }
    }
}
