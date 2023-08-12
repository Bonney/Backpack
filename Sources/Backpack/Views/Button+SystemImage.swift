import SwiftUI

/// An extension for the `Button` struct that allows creating a button with a system image as its label.
public extension Button where Label == Image {

    /// Creates a new button with the specified system image and action closure.
    /// - Parameters:
    ///   - systemImage: The name of the system image to use as the button's label.
    ///   - role: The role of the button. Defaults to `nil`.
    ///   - action: A closure that will be called when the button is tapped.
    init(systemImage: String, role: ButtonRole? = nil, action: @escaping () -> Void) {
        self.init(role: role, action: action, label: {
            Image(systemName: systemImage)
        })
    }
}


struct SystemImageButtonDemo: View {
    @State private var someBool = false

    var body: some View {
        Button(systemImage: "star") {
            someBool.toggle()
        }
        .symbolVariant(someBool ? .fill : .none)
        .buttonStyle(.bordered)
        .tint(someBool ? Color.blue : Color.secondary)
    }
}

struct SystemImageButtonDemo_Previews: PreviewProvider {
    static var previews: some View {
        SystemImageButtonDemo()
    }
}
