import SwiftUI

struct CustomSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>

    init(value: Binding<Double>, in range: ClosedRange<Double>) {
        self._value = value
        self.range = range
    }

    private let grabberSize: CGFloat = 36.0

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Image(systemName: "circle")
                    .resizable()
                    .fontWeight(.black)
                    .foregroundStyle(Color.white.gradient.shadow(.drop(color: Color.gray, radius: 1.0)))
                    .scaleEffect(0.8)
                    .frame(width: grabberSize, height: grabberSize)
                    .frame(width: geometry.size.width, alignment: .leading)
                    .offset(x: self.xOffset(in: geometry.size.width - grabberSize))
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                self.onDragChange(gesture, width: geometry.size.width - grabberSize)
                            }
                    )
            }
        }
        .frame(height: grabberSize)
        .background(
            .background.shadow(
                .drop(color: Color.primary.opacity(1.0), radius: 0.5)
            ),
            in: .capsule
        )
    }

    private func xOffset(in availableWidth: CGFloat) -> CGFloat {
        let normalized = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
        return CGFloat(normalized) * availableWidth
    }

    private func onDragChange(_ gesture: DragGesture.Value, width: CGFloat) {
        let normalized = max(0, min(1, gesture.location.x / width))
        value = (range.upperBound - range.lowerBound) * Double(normalized) + range.lowerBound
    }
}

#Preview {
    @Previewable @State var value = 0.5
    VStack {
        Text("Value: \(value.formatted())")
            .font(.largeTitle)
        CustomSlider(value: $value, in: 0.0...1.0)
    }
}
