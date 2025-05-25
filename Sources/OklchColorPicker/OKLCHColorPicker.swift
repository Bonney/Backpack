import SwiftUI

public struct OKLCHColorPicker: View {
    @Binding var selection: ColorComponents

    public init(selection: Binding<ColorComponents>) {
        self._selection = selection
    }

    public var body: some View {
        VStack {
            CustomSlider(value: $selection.hue, in: ColorComponents.hueRange)
                .backgroundStyle(HueGradient())
            HStack {
                CustomSlider(value: $selection.luminance, in: ColorComponents.luminanceRange)
                    .backgroundStyle(LuminanceGradient(chroma: selection.chroma, hue: selection.hue))

                CustomSlider(value: $selection.chroma, in: ColorComponents.chromaRange)
                    .backgroundStyle(ChromaGradient(luminance: selection.luminance, hue: selection.hue))
            }
        }
    }
}

#Preview {
    @Previewable @State var color = ColorComponents.random

    OKLCHColorPicker(selection: $color)
        .padding()
        .border(color, width: 10.0)
}

#Preview {
    @Previewable @State var color = ColorComponents.random

    VStack {
        Spacer()

        Text("40")
            .font(.system(size: 200.0, weight: .semibold, design: .default))
            .foregroundStyle(
                color.contrastingColor
            )

        Spacer()

        OKLCHColorPicker(selection: $color)

        Spacer()

        Button("Random") {
            withAnimation(.snappy(duration: 0.25)) {
                color = ColorComponents.random
            }
        }
        .buttonStyle(.bordered)
        .tint(color.contrastingColor)
    }
    .padding()
    .background(color, ignoresSafeAreaEdges: .all)
}
