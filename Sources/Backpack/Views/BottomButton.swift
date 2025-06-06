import SwiftUI

extension View {
    @ViewBuilder
    public func bottomButton<V: View>(
        maxWidth: CGFloat? = .infinity,
        blurBottom: Bool = true,
        @ViewBuilder button: @escaping () -> V
    ) -> some View {
        safeAreaInset(edge: .bottom, alignment: .center, spacing: nil) {
            button()
                .buttonStyle(.smooth(maxWidth: maxWidth))
                .controlSize(.large)
                .padding(8.0)
                .padding(.top, 8.0) // for variable blur background padding
                .background {
                    if blurBottom {
                        VariableBlurView(
                            maxBlurRadius: 8.0,
                            direction: .blurredBottomClearTop,
                            startOffset: 0.0
                        )
                        .ignoresSafeArea()
                    }
                }
        }
    }
}

struct FloatingBottomButtonDemoView: View {
    @State var current: Int = 0
    let count: Int = 100
    var color: Color { Color(hueOutOf360: 360 * Double(current) / 100.0) }

    var body: some View {
        NavigationStack {
            List(0..<100, id: \.self) { i in
                Label {
                    Text("Row \(i)")
                } icon: {
                    Image(systemName: "circle.fill")
                        .imageScale(.large)
                        .foregroundStyle(Color(hueOutOf360: 360 * Double(i) / 100.0))
                }
                .onAppear(perform: {
                    withAnimation(.smooth) {
                        current = i
                    }
                })
            }
            .bottomButton {
                Button("New Item", systemImage: "plus", action: { })
                    .tintColor(color)
            }
        }
        .tintColor(Color.blue)
    }
}

#Preview {
    FloatingBottomButtonDemoView()
}
