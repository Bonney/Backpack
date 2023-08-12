//
//  Created by Matt Bonney on 11/23/22.
//

import SwiftUI

public enum SheetDismissLabel: String {
    case dismiss, cancel, done, xmark
}

/// Calls `dismiss` on the current environment, meant to dismiss sheets.
public struct SheetDismissButton: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    var label: SheetDismissLabel

    /// Optional, additional action to execute upon button press, before dismiss is called.
    var action: (() -> Void)?

    public init(label: SheetDismissLabel, action: (() -> Void)? = nil) {
        self.label = label
        self.action = action
    }

    public var body: some View {
        Button(role: .cancel) {
            action?()
            dismiss.callAsFunction()
        } label: {
            buttonLabel()
        }
        .disabled(!presentationMode.wrappedValue.isPresented)
    }

    @ViewBuilder func buttonLabel() -> some View {
        switch label {
        case .xmark:
            Image(systemName: "xmark")
        case .dismiss, .cancel, .done:
            Text(label.rawValue.capitalized)
        }
    }
}

/// Places a MBUtilities `EllipsisMenuButton` in the NavigationBar's `.navigationBarTrailing` position.
public struct ToolbarSheetDismissButton: ToolbarContent {
    let label: SheetDismissLabel
    var action: (() -> Void)?

    public init(label: SheetDismissLabel, action: (() -> Void)? = nil) {
        self.label = label
        self.action = action
    }

    public var body: some ToolbarContent {
        #if os(watchOS)
        let placement = ToolbarItemPlacement.cancellationAction
        #else
        let placement = ToolbarItemPlacement.navigation
        #endif
        ToolbarItem(placement: placement) {
            SheetDismissButton(label: label, action: action)
        }
    }
}

struct SheetDismissButton_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            SheetDismissButton(label: .done)

            SheetDismissButton(label: .cancel) {
                print("cancel")
            }

            SheetDismissButton(label: .xmark) {
                print("xmark tapped")
            }
        }
    }
}
