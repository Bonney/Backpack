import SwiftUI
import Foundation

/// A control container that replicates the background of an iOS DatePicker in the compact style.
public struct CompactGrayControlPlatter<Content: View>: View {
    @ViewBuilder let content: () -> Content

    // THESE ARE MAGIC IDEAL VALUES. DO NOT TOUCH.
    private let idealContentHeight: Double = 20.0
    private let verticalPadding: Double = 8.0
    private let horizontalPadding: Double = 10.0
    private let backgroundCornerRadius: Double = 7.0

    public init(content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        content()
            .frame(minHeight: idealContentHeight, idealHeight: idealContentHeight)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: backgroundCornerRadius, style: .continuous))
    }
}

/// A container that replicates the background of an iOS "toast" notification.
public struct MiniNotificationCapsule<Content: View>: View {
    @ViewBuilder let content: () -> Content

    // THESE ARE MAGIC IDEAL VALUES. DO NOT TOUCH.
    private let idealContentHeight: Double = 20.0
    private let verticalPadding: Double = 8.0
    private let horizontalPadding: Double = 10.0
    private let backgroundCornerRadius: Double = 7.0

    public init(content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        content()
            .frame(minHeight: idealContentHeight, idealHeight: idealContentHeight)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .background {
                Capsule()
                    .fill(.regularMaterial)
                    .shadow(color: .secondary.opacity(0.3), radius: 8, x: 0, y: 4)
                    .overlay {
                        Capsule().stroke(.secondary.opacity(0.1), lineWidth: 1.0)
                    }
            }
    }
}

struct MiniNotificationContent: Equatable {
    let title: String
    let subtitle: String
    let leadingSymbol: String
    let trailingSymbol: String
    let accentColor: Color

    static let previewImported = MiniNotificationContent(title: "16.9 fl oz Drink", subtitle: "Imported from Health", leadingSymbol: "heart.fill", trailingSymbol: "arrow.down.circle.fill", accentColor: Color.pink)

    static let previewSaved = MiniNotificationContent(title: "24 fl oz Drink", subtitle: "Saved Successfully", leadingSymbol: "drop.fill", trailingSymbol: "checkmark.circle.fill", accentColor: Color.blue)
}

struct MiniNotificationView: View {
    let content: MiniNotificationContent

    var body: some View {
        MiniNotificationCapsule {
            HStack(spacing: 0) {
                ZStack {
                    Image(systemName: "circle.fill").opacity(0.0)
                    Image(systemName: content.leadingSymbol)
                }
                .foregroundStyle(content.accentColor.gradient)

                VStack(alignment: .center) {
                    Text(content.title)
                        .font(.system(.subheadline, design: .rounded, weight: .semibold))

                    Text(content.subtitle)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)

                Image(systemName: content.trailingSymbol)
                    .foregroundStyle(.secondary)
                    .aspectRatio(1, contentMode: .fit)
            }
        }
        .imageScale(.large)
    }
}

struct MiniNotificationPresenter: View {
    @State var content: MiniNotificationContent? = nil

    var body: some View {
        VStack {
            Spacer()

            HStack {

                Button {
                    withAnimation(.bouncy) {
                        if content == nil {
                            content = .previewSaved
                            Task {
                                try? await Task.sleep(for: .seconds(2))
                                await MainActor.run {
                                    withAnimation(.bouncy) {
                                        content = nil
                                    }
                                }
                            }
                        } else {
                            content = nil
                        }
                    }
                } label: {
                    CompactGrayControlPlatter {
                        Text(content == nil ? "Show" : "Hide")
                            .contentTransition(.numericText())
                    }
                }
                .buttonStyle(.plain)

                Button {
                    content = nil
                } label: {
                    CompactGrayControlPlatter {
                        Text("Hide")
                    }
                }
                .buttonStyle(.plain)

                Button {
                    content = .previewImported
                } label: {
                    CompactGrayControlPlatter {
                        Text("Show Imported")
                    }
                }
                .buttonStyle(.plain)

            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .top) {
            if let content {
                MiniNotificationView(content: content)
                    .transition(.blurReplace)
//                    .transition(.move(edge: .top).combined(with: .blurReplace))
            }
        }
    }
}

struct MiniNotificationViewPreview: PreviewProvider {
    static var previews: some View {
        MiniNotificationPresenter()
    }
}
