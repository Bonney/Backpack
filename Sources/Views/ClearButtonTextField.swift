//
//  Created by Matt Bonney on 11/23/22.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .trailing) {
                Button(systemImage: "xmark.circle.fill", action: action)
                    .tint(.secondary)
            }
    }
}

public extension View {
    func clearButton(_ action: @escaping () -> Void) -> some View {
        modifier(TextFieldClearButton(action: action))
    }
}

/// A custom text field with a clear button that is displayed when the text field is not empty.
///
/// You can set the label of the text field using a closure. The clear button appears on the right side of the text field and is only visible when the text field contains text.
public struct ClearButtonTextField<Label: View>: View {
    /// The label of the text field.
    let label: Label
    /// The binding of the text in the text field.
    let text: Binding<String>
    /// The prompt to display in the text field. The prompt is optional and can be omitted.
    let prompt: Text?
    /// The axis of the text field. The default value is `.horizontal`.
    let axis: Axis

    /// Initializes a new `ClearButtonTextField` instance.
    ///
    /// - Parameters:
    ///   - text: A binding of the text in the text field.
    ///   - prompt: The prompt to display in the text field. The default value is `nil`.
    ///   - axis: The axis of the text field. The default value is `.horizontal`.
    ///   - label: A closure that returns the label of the text field.
    public init(text: Binding<String>,
                prompt: Text? = nil,
                axis: Axis = .horizontal,
                @ViewBuilder label: () -> Label) {
        self.text = text
        self.prompt = prompt
        self.axis = axis
        self.label = label()
    }

    /// The body of the view.
    public var body: some View {
        TextField(text: self.text, axis: self.axis) {
            self.label
        }
            .overlay(alignment: .trailing) {
                clearButton
                    .opacity(text.wrappedValue == "" ? 0 : 1)
                    .animation(.easeOut, value: text.wrappedValue)
                    .padding(.horizontal, 4)
            }
    }

    /// The clear button that appears on the right side of the text field.
    private var clearButton: some View {
        Button {
            text.wrappedValue = ""
        } label: {
            Image(systemName: "xmark.circle.fill")
        }
        .tint(.secondary)
    }
}

/// A simple example view that demonstrates how to use the `ClearButtonTextField`.
fileprivate struct ExampleView: View {
    /// The text to display in the text field.
    @State private var x = "Hello"
    /// The body of the view.
    var body: some View {
        List {
            Section("ClearButtonTextField") {
                ClearButtonTextField(text: $x, prompt: Text("Type Here.")) {
                    Text("My Label")
                }
            }

            Section("View Modifier") {
                TextField("Type Here", text: $x)
                    .clearButton {
                        x = ""
                    }
            }
        }
    }
}

/// The preview provider for the `ClearButtonTextField`.
struct TextFieldWithClearButton_Previews: PreviewProvider {
    /// The previews of the `ClearButtonTextField`.
    static var previews: some View {
        ExampleView()
    }
}
