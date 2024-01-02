import SwiftUI

/// A Progress ring UI element that simulates the Activity/Fitness rings.
public struct Ring: View {
    var progress: Double
    let lineWidth: Double

    public init(progress: Double, lineWidth: Double) {
        self.progress = progress
        self.lineWidth = lineWidth
    }

    public var body: some View {
        ZStack {
            RingBackground(lineWidth: lineWidth)
            RingFill(progress: progress, lineWidth: lineWidth)
        }
        .rotationEffect(.degrees(-90))
    }
}

struct RingBackground: View {
    let lineWidth: Double

    var body: some View {
        Circle()
            .trim(from: 0.0, to: 1.0)
            .stroke(.quaternary, lineWidth: lineWidth)
    }
}

struct RingFill: View {
    let progress: Double
    let lineWidth: Double
    let transitionPoint: Double = 0.98

    var strokeStyle: StrokeStyle {
        StrokeStyle(lineWidth: lineWidth, lineCap: .round)
    }

    var gradientColors: [Gradient.Stop] {
        if progress < transitionPoint {
            [
                Gradient.Stop(color: Color.black, location: 0.0)
            ]
        } else {
            [
                Gradient.Stop(color: Color.black.opacity(0.2), location: 0.0),
                Gradient.Stop(color: Color.black.opacity(1.0), location: 0.5)
            ]
        }
    }

    var fillStyle: AngularGradient {
        AngularGradient(stops: gradientColors, center: .center, angle: .degrees(0.0))
    }

    var rotation: Angle {
        if progress < transitionPoint {
            return .degrees(0.0)
        } else {
            return .degrees(progress * 360)
        }
    }

    var body: some View {
        let _ = Self._printChanges()

        Circle()
            .trim(from: 0.0, to: progress)
            .stroke(style: strokeStyle)
            .fill(.primary)
            .mask { fillMask }
        //            .animation(.easeOut, value: progress)
            .rotationEffect(rotation)
    }

    var fillMask: some View {
        Circle()
            .stroke(style: strokeStyle)
            .fill(fillStyle)
            .overlay(alignment: .trailing) { fillCap }
    }

    var fillCap: some View {
        Circle()
            .frame(width: lineWidth, height: lineWidth)
            .offset(x: lineWidth / 2)
    }
}

struct RingPreview<Content: View>: View {
    @State var progress: Double = 0.5
    @ViewBuilder var ring: (Double) -> Content

    var body: some View {
        VStack {
            ring(progress)
                .padding()

            VStack(alignment: .leading) {
                Text(progress, format: .percent)
                    .monospacedDigit()

                Slider(value: $progress, in: 0...5)

                ControlGroup {
                    Button("Reset") {
                        setValue(0.0)
                    }

                    Button("Randomize...") {
                        let newValue = Double.random(in: 0...5)
                        setValue(newValue)
                    }
                }
            }
        }
        .padding()
    }

    func setValue(_ newValue: Double) {
        let distance = abs(newValue - progress)
        let time = distance * 1.0
        withAnimation(.easeOut(duration: time)) {
            progress = newValue
        }
    }
}
#Preview {
    RingPreview { progress in
        Ring(progress: progress, lineWidth: 36)
    }
    .foregroundStyle(Color.blue)
}
