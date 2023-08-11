import SwiftUI

/// A `View` that presents a sheet when a button is pressed.
/// - Parameters:
///   - role: The role of the button.
///   - label: A closure that returns the label to display on the button.
///   - sheetContent: A closure that returns the content to display in the sheet.
public struct SheetButton<ButtonLabel: View, SheetContent: View>: View {
    @State private var showSheet: Bool = false
    let buttonRole: SwiftUI.ButtonRole?
    let buttonLabel: ButtonLabel
    let sheetContent: SheetContent

    /// Initializes a `SheetButton`.
    /// - Parameters:
    ///   - role: The role of the button. The default value is `nil`.
    ///   - label: A closure that returns the label to display on the button.
    ///   - sheetContent: A closure that returns the content to display in the sheet.
    public init(role: SwiftUI.ButtonRole? = nil, @ViewBuilder label: @escaping () -> ButtonLabel, @ViewBuilder sheetContent: @escaping () -> SheetContent) {
        self.buttonRole = role
        self.buttonLabel = label()
        self.sheetContent = sheetContent()
    }

    public var body: some View {
        /// Displays a button that, when pressed, presents a sheet.
        Button(role: self.buttonRole ?? .none) {
            self.showSheet.toggle()
        } label: {
            self.buttonLabel
        }
        .sheet(isPresented: $showSheet) {
            self.sheetContent
        }

    }
}
