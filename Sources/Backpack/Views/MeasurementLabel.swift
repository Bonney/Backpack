import SwiftUI
import Foundation

/// A structure that takes a `Measurement` type and renders
/// two horizontally-aligned labels for the value and unit.
public struct MeasurementLabel<Content, UnitType>: View where Content: View, UnitType: Unit {
    let measurement: Measurement<UnitType>
    let fractionLength: Int
    let alignment: VerticalAlignment
    let spacing: CGFloat?

    let content: (Text, Text) -> Content

    public init(
        _ measurement: Measurement<UnitType>,
        fractionLength: Int = 1,
        alignment: VerticalAlignment = .firstTextBaseline,
        spacing: CGFloat?,
        @ViewBuilder content: @escaping (_ value: Text, _ symbol: Text) -> Content
    ) {
        self.measurement = measurement
        self.fractionLength = fractionLength
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
    }

    public var body: some View {
        HStack(alignment: alignment, spacing: spacing) {
            content(
                Text(measurement.value, format: .number.precision(.fractionLength(fractionLength))),
                Text(measurement.unit.symbol)
            )
        }
    }
}


#Preview {
    MeasurementLabel(Measurement(value: 16.9, unit: UnitVolume.fluidOunces), spacing: 2) { value, symbol in
        value
            .font(.system(size: 80, weight: .semibold, design: .rounded))
        symbol
            .font(.system(size: 32, weight: .regular, design: .rounded))
            .foregroundStyle(.secondary)
    }
    .frame(width: 300, height: 200, alignment: .center)

}
