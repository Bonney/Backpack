//
//  OpenGauge.swift
//  Deliveries Widget
//
//  Created by Mike Piontek on 8/29/22.
//
// https://gist.github.com/robotspacer/efdecb58c2c5d7963ee99fdd67cf03fc
//

import SwiftUI

/// A custom view similar to `Gauge`. It displays an open ring that’s partially
/// filled in to indicate the gauge’s current value. The `label` is shown in
/// the open area at the bottom, and the `centerView` is shown in the middle.
/// This is intended to match as closely as possible the appearance of similar
/// Apple widgets, like the Weather Precipitation widget.
public struct OpenCapacityGaugeStyle: GaugeStyle {
    public func makeBody(configuration: Configuration) -> some View {
        OpenGauge(value: Float(configuration.value)) {
            configuration.currentValueLabel
        } centerView: {
            configuration.label
        }
    }
}

public extension GaugeStyle where Self == OpenCapacityGaugeStyle {
    static var openCapacity: Self {
        return .init()
    }
}

/// A custom view similar to `Gauge`. It displays an open ring that’s partially
/// filled in to indicate the gauge’s current value. The `label` is shown in
/// the open area at the bottom, and the `centerView` is shown in the middle.
/// This is intended to match as closely as possible the appearance of similar
/// Apple widgets, like the Weather Precipitation widget.

public struct OpenGauge<Label, CenterView>: View where Label: View, CenterView: View {

    private let value: Float?

//    private let trackColor: Color
    private var trackOpacity: Double = 0.1

//    private let fillColor: Color

    private let label: Label

    private let centerView: CenterView

    public init(value: Float?,
//                trackColor: Color = Color(white: 0.1),
//                fillColor: Color = .primary,
                @ViewBuilder label: () -> Label,
                @ViewBuilder centerView: () -> CenterView) {
        self.value = value
//        self.trackColor = trackColor
//        self.fillColor = fillColor
        self.label = label()
        self.centerView = centerView()
    }

    public var body: some View {
        GeometryReader { geometry in
            let value = CGFloat(value ?? 0)
            let width = geometry.size.width
            let height = geometry.size.height
            let diameter = min(width, height)
            let thickness = diameter / 10.5
            let inset = thickness / 2
            let trimFrom: CGFloat = 0.125
            let trimTo: CGFloat = 0.875
            let trimFillTo: CGFloat = trimFrom + ((trimTo - trimFrom) * value)
            ZStack {
                Circle()
                    .trim(from: trimFrom, to: trimTo)
                    .stroke(style: StrokeStyle(lineWidth: thickness, lineCap: .round))
                    .rotationEffect(.degrees(90))
                    .foregroundStyle(.tint)
                    .opacity(trackOpacity)
//                    .foregroundColor(trackColor)
                    .padding(inset)
                Circle()
                    .trim(from: trimFrom, to: trimFillTo)
                    .stroke(style: StrokeStyle(lineWidth: thickness, lineCap: .round))
                    .rotationEffect(.degrees(90))
                    .foregroundStyle(.tint)
//                    .foregroundColor(fillColor)
                    .padding(inset)
                label
                    .padding(.bottom, 3)
                    .frame(width: width, height: height, alignment: .bottom)
                centerView
                    .foregroundStyle(.tint)
                    .offset(x: 0, y: -1)
            }
        }
    }
}

struct OpenGauge_Previews: PreviewProvider {
    static var previews: some View {
//        OpenGauge(value: 0.5) {
//            Text("Label")
//        } centerView: {
//            Image(systemName: "star")
//        }

        Gauge(value: 3.0, in: 0...10) {
            Image(systemName: "drop.fill")
        }
        .gaugeStyle(.openCapacity)
        .tint(.blue)
        .frame(width: 40, height: 40)
        .previewLayout(.sizeThatFits)

    }
}
