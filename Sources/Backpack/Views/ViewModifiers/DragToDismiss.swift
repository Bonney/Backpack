import SwiftUI

extension View {
    public func dragToDismiss(distance: CGFloat, beforeDismiss: (() -> Void)? = nil) -> some View {
        self.modifier(
            DragDownToDismissViewModifier(dragAutoDismissTarget: distance, beforeDismiss: beforeDismiss)
        )
    }
}

struct DragDownToDismissViewModifier: ViewModifier {
    @Environment(\.dismiss) private var environmentDismiss
    @GestureState private var dragOffset: CGFloat = 0.0

    private let dragAutoDismissTarget: CGFloat
    private let beforeDismiss: (() -> Void)?

    init(dragAutoDismissTarget: CGFloat, beforeDismiss: (() -> Void)?) {
        self.dragAutoDismissTarget = dragAutoDismissTarget
        self.beforeDismiss = beforeDismiss
    }

    func body(content: Content) -> some View {
        content
            .offset(y: dragOffset)
            .gesture(dragGesture)
            .animation(.smooth, value: dragOffset)
    }

    private var dragGesture: GestureStateGesture<DragGesture, CGFloat> {
        DragGesture().updating($dragOffset) { value, state, transaction in
            // Get the vertical drag distance.
            let distance = value.translation.height

            // Ignore changes if user is swiping upwards.
            guard distance > 0 else { return }

            // Assign new distance value to the state variable.
            state = distance

            // Check if we've crossed the threshold to auto-dismiss.
            if distance >= dragAutoDismissTarget {
                dismissAction()
            }
        }
    }

    private func dismissAction() {
        beforeDismiss?()
        environmentDismiss()
    }
}

// MARK: - Examples

// Mark as deprecated
@available(*, deprecated, message: "DragToDismissFullScreenMaterialCard should be implemented as custom app UI.")
public struct DragToDismissFullScreenMaterialCard<Content: View>: View {
    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    private let backgroundShape = RoundedRectangle(cornerRadius: 50, style: .continuous)

    public var body: some View {
        ZStack {
            content
        }
        .background {
            // Background Shape/Material
            backgroundShape
                .foregroundStyle(.background.shadow(.drop(color: Color.black.opacity(0.125), radius: 10, x: 0, y: 0)))
                .ignoresSafeArea()
        }
        .scrollContentBackground(.hidden)
        .presentationBackground(Color.clear)
        .presentationDragIndicator(.visible)
        .backgroundStyle(.regularMaterial)
        .containerShape(backgroundShape)
        .dragToDismiss(distance: 200)
    }
}
