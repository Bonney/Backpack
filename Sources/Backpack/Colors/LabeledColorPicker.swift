import SwiftUI

public enum LabeledColorPickerStyle: Int, Equatable {
    case rounded = 0
    case square = 1
}

private extension LabeledColor {
    /// Hue in degrees. Prefers the OKLCH hue, which follows perceived hue more closely than HSB.
    var sortingHue: Double {
        components?.hue ?? Double(color.hue) * 360
    }
}

private struct LabeledColorPickerDetail: View {
    private enum SortingOption: Int, Equatable, CaseIterable, Identifiable {
        case defaultSort = 0
        case sortByHue = 1

        var id: Int { self.rawValue }

        var name: String {
            switch self {
                case .defaultSort:
                    return "Default"
                case .sortByHue:
                    return "Hue"
            }
        }
    }

    @Environment(\.dismiss) var dismiss
    @State private var sortingOption = SortingOption.defaultSort

    let style: LabeledColorPickerStyle
    let colorOptions: [LabeledColor]
    let onSelection: (LabeledColor) -> Void

    private let cellHeight: Double = 60.0

    init(colorOptions: [LabeledColor], style: LabeledColorPickerStyle, onSelection: @escaping (LabeledColor) -> Void) {
        self.colorOptions = colorOptions
        self.style = style
        self.onSelection = onSelection
    }

    @State private var filter: String = ""

    private var filteredOptions: [LabeledColor] {
        let filtered: [LabeledColor]

        if filter.isEmpty {
            filtered = colorOptions
        } else {
            filtered = colorOptions.filter({ c in
                c.name.localizedCaseInsensitiveContains(filter)
            })
        }

        switch sortingOption {
            case .defaultSort:
                return filtered
            case .sortByHue:
                return filtered.sorted { $0.sortingHue > $1.sortingHue }
        }
    }

    var scrollView: some View {
        ScrollView(.vertical) {
            LazyVGrid(
                columns: Array(repeating: GridItem(spacing: style == .rounded ? 8 : 1), count: 3),
                spacing: style == .rounded ? 8 : 1
            ) {
                ForEach(filteredOptions) { option in
                    cell(for: option)
                        .onTapGesture {
                            select(option)
                        }
                }
            }
            .padding(style == .rounded ? 8 : 0)
        }
        .toolbar {
            ToolbarItemGroup {
                Picker("Sort", selection: $sortingOption) {
                    ForEach(SortingOption.allCases) { option in
                        Text(option.name).tag(option)
                    }
                }

                Button {
                    if let random = colorOptions.randomElement() {
                        select(random)
                    }
                } label: {
                    Label("Random", systemImage: "shuffle")
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss.callAsFunction()
                }
            }
        }
        .navigationTitle("Pick a Color")
    }

    var body: some View {
        #if os(macOS)
        NavigationStack {
            scrollView
                .searchable(text: $filter, placement: .toolbar, prompt: Text("Filter..."))
        }
        #else
        NavigationStack {
            scrollView
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
                .searchable(text: $filter, placement: .automatic, prompt: Text("Filter..."))

        }
        #endif
    }

    @ViewBuilder func cell(for labeledColor: LabeledColor) -> some View {
        let shape = RoundedRectangle(cornerRadius: (style == .rounded ? 12 : 0), style: .continuous)

        ZStack {
            shape
                .stroke(.tertiary, lineWidth: style == .rounded ? 1 : 0)
            shape
                .foregroundColor(labeledColor.color)
        }
            .frame(height: self.cellHeight)
            .overlay {
                labeledColor.label.labelStyle(.titleOnly)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(labeledColor.color.contrastingForegroundColor())
            }
    }

    func select(_ labeledColor: LabeledColor) {
        onSelection(labeledColor)
        dismiss.callAsFunction()
    }
}

public struct LabeledColorPicker: View {
    @State private var presentPickerDetail: Bool = false

    @Binding public var selected: LabeledColor
    let style: LabeledColorPickerStyle
    public let colorOptions: [LabeledColor]

    public init(
        selected: Binding<LabeledColor>,
        style: LabeledColorPickerStyle,
        options: [LabeledColor]
    ) {
        self._selected = selected
        self.style = style
        self.colorOptions = options
    }

    /// Picks a `ColorComponents` value from `options`.
    ///
    /// Options without OKLCH components (such as system colors) can't be represented and are left out.
    /// A selection that matches none of the options is shown as "Custom".
    public init(
        selection: Binding<ColorComponents>,
        style: LabeledColorPickerStyle,
        options: [LabeledColor]
    ) {
        let options = options.filter { $0.components != nil }
        self.init(
            selected: Binding(
                get: {
                    options.first { $0.components == selection.wrappedValue }
                        ?? LabeledColor("Custom", components: selection.wrappedValue)
                },
                set: { newValue in
                    if let components = newValue.components {
                        selection.wrappedValue = components
                    }
                }
            ),
            style: style,
            options: options
        )
    }

    public var body: some View {
        Button {
            print("toggling")
            presentPickerDetail.toggle()
        } label: {
            LabeledContent {
                Image(systemName: "chevron.up.chevron.down")
            } label: {
                selected.label
            }
        }
        .buttonStyle(.plain)
        .foregroundStyle(.primary)
        .sheet(isPresented: $presentPickerDetail) {
            if #available(iOS 16.4, macOS 13.3, watchOS 9.4, *) {
                LabeledColorPickerDetail(colorOptions: self.colorOptions, style: style) { selection in
                    self.selected = selection
                }
                .presentationDetents([.medium, .large])
                .presentationContentInteraction(.scrolls)
            } else {
                LabeledColorPickerDetail(colorOptions: self.colorOptions, style: style) { selection in
                    self.selected = selection
                }
                .presentationDetents([.medium, .large])
            }
        }
    }
}

private struct LabeledColorPicker_Demo: View {
    @State private var selected: LabeledColor = LabeledColor.malachite

    var body: some View {
        Form {
            LabeledColorPicker(selected: $selected, style: .square, options: LabeledColorSet.allColorSets)
        }
    }
}

private struct LabeledColorPicker_ComponentsDemo: View {
    @State private var selection: ColorComponents = .malachite

    var body: some View {
        Form {
            LabeledColorPicker(selection: $selection, style: .rounded, options: LabeledColorSet.allColorSets)
            Rectangle()
                .fill(selection)
                .frame(height: 44)
        }
    }
}

struct LabeledColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        LabeledColorPickerDetail(colorOptions: LabeledColorSet.allColorSets, style: .rounded, onSelection: { _ in })
        LabeledColorPicker_Demo()
        LabeledColorPicker_ComponentsDemo()
    }
}
