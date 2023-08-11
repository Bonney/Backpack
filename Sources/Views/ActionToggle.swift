//
//  Created by Matt Bonney on 11/23/22.
//

import SwiftUI

/// SwiftUI `Toggle` that executes an `.onChange(of:)` for the bound value.
public struct ActionToggle<Label: View>: View {
    @Binding var isOn: Bool
    let label: Label
    let action: (Bool) -> Void

    /// SwiftUI `Toggle` that executes an `.onChange(of:)` for the bound value.
    /// - Parameters:
    ///   - isOn: Bound value; matches SwiftUI.Toggle `isOn`.
    ///   - label: View to use for label; matches SwiftUI.Toggle `label`.
    ///   - action: Completion method called when `isOn` bound value changes.
    public init(isOn: Binding<Bool>, @ViewBuilder label: () -> Label, action: @escaping (Bool) -> Void) {
        self._isOn = isOn
        self.label = label()
        self.action = action
    }

    public var body: some View {
        Toggle(isOn: $isOn) {
            label
        }
        .onChange(of: isOn) { newValue in
            action(newValue)
        }
    }
}

fileprivate struct ActionToggle_Example: View {
    @State private var isOn: Bool = false
    @State private var output: String = "init"
    var body: some View {
        VStack {
            Text(output)
                .foregroundStyle(isOn ? Color.green : Color.red)

            ActionToggle(isOn: $isOn) {
                Text("ActionToggle")
            } action: { newValue in
                output = "'\(newValue)' at \(Date.now)"
            }
        }
        .padding()
    }
}

struct ActionToggle_Previews: PreviewProvider {
    static var previews: some View {
        ActionToggle_Example()
    }
}
