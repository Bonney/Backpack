import SwiftUI

public struct AnimatedNumber: View {
    @Binding private var value: Double

    @State private var originalValue: Double = 0.0
    @State private var destinationValue: Double = 0.0
    @State private var percentage: Double = 0.0

    private let duration: TimeInterval
    private let formatter: Formatter

    public init(
        _ value: Binding<Double>,
        duration: TimeInterval = 0.7,
        fractionDigits: Int = 1,
        numberStyle: NumberFormatter.Style = .none
    ) {
        let formatter: NumberFormatter = {
            let f = NumberFormatter()
            f.minimumFractionDigits = fractionDigits
            f.maximumFractionDigits = fractionDigits
            f.numberStyle = numberStyle
            return f
        }()

        self.init(value, duration: duration, formatter: formatter)
    }

    public init(
        _ value: Binding<Double>,
        duration: TimeInterval = 0.7,
        formatter: NumberFormatter
    ) {
        self._value = value
        self.originalValue = value.wrappedValue
        self.destinationValue = value.wrappedValue

        self.duration = duration
        self.formatter = formatter
    }

    public var body: some View {
        EmptyView()
            .modifier(
                AnimatedNumberModifier(
                    value: $value,
                    originalValue: $originalValue,
                    destinationValue: $destinationValue,
                    duration: duration,
                    percentage: $percentage,
                    formatter: formatter
                )
            )
    }
}

fileprivate struct AnimatedNumberModifier: AnimatableModifier {
    private var animationPercentage: Double
    @Binding private var destinationValue: Double
    private let formatter: Formatter
    @Binding private var originalValue: Double
    @Binding private var percentage: Double
    private var duration: Double
    @Binding private var value: Double

    init(
        value: Binding<Double>,
        originalValue: Binding<Double>,
        destinationValue: Binding<Double>,
        duration: Double,
        percentage: Binding<Double>,
        formatter: Formatter
    ) {
        _value = value
        _originalValue = originalValue
        _destinationValue = destinationValue
        self.duration = duration
        _percentage = percentage
        animationPercentage = percentage.wrappedValue
        self.formatter = formatter
    }

    var animatableData: Double {
        get { animationPercentage }
        set { animationPercentage = newValue }
    }

    private var animatedValue: Double {
        originalValue + ((destinationValue - originalValue) * animationPercentage)
    }

    func makeText() -> some View {
        Text(displayValue)
            .onChange(of: value) { _ in
                valueDidChange()
            }
    }

    func valueDidChange() {
        if isAnimating {
            // Restart the animation from the current value to the destination value.
            withAnimation(.linear(duration: 0)) {
                percentage = 0
            }

            DispatchQueue.main.async {
                originalValue = animatedValue
                destinationValue = value

                withAnimation(.linear(duration: duration)) {
                    percentage = 1
                }
            }
        } else {
            destinationValue = value

            withAnimation(.linear(duration: duration)) {
                percentage = 1
            }
        }
    }

    func body(content: Content) -> some View {
        if animationPercentage == 1 {
            DispatchQueue.main.async {
                percentage = 0
                originalValue = value
                destinationValue = value
            }
        }
        return makeText()
    }

    private var displayValue: String {
        formatter.string(for: animatedValue as NSNumber)!
    }

    private var isAnimating: Bool {
        percentage != 0
    }
}

struct AnimatedNumber_Demo: View {
    @State private var number: Double = 0.0
    @State private var fractionDigits: Double = 1.0
    private let range: ClosedRange<Double> = 0...100

    var body: some View {
        VStack(spacing: 20) {

            AnimatedNumber($number, duration: 0.5, fractionDigits: Int(fractionDigits), numberStyle: .decimal)
                .font(.largeTitle.monospaced())

            Divider()

            Button("Random") {
                withAnimation(.spring()) {
                    number = Double.random(in: range)
                }
            }

            Divider()

            VStack {
                Text("Number: \(Text(number, format: .number))")
                Slider(value: $number, in: range)
            }

            Divider()

            VStack {
                Text("Fraction Digits: \(Text(Int(fractionDigits), format: .number))")
                Slider(value: $fractionDigits, in: 0...5)
            }
        }
        .padding()

    }
}

struct AnimatedNumber_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedNumber_Demo()
    }
}
