//
//  Color+.swift
//  MBColorSchemeAccentPicker
//
//  Created by Matt Bonney on 12/21/22.
//

import SwiftUI
import Extensions
import Views

enum ColorSchemeChoice: Int, Identifiable, Equatable {
    case match = 0
    case light = 1
    case dark = 2

    var id: Int { self.rawValue }
}

struct MBColorSchemeAccentPicker: View {
    @Environment(\.colorScheme) var systemColorScheme

    var colorSchemeToUse: ColorScheme {
        if matchSystem {
            return systemColorScheme
        }

        if colorScheme == .dark {
            return ColorScheme.dark
        }

        return ColorScheme.light
    }

    @State private var accentColor: LabeledColor = LabeledColor.malachite
    @State private var matchSystem: Bool = true
    @State private var colorScheme: ColorSchemeChoice = .match

    let iconSize: Double = 30.0

    var rainbow: some View {
        LinearGradient(colors: Color.gemstoneColors, startPoint: .leading, endPoint: .trailing)
    }

    func smallThemePreview() -> some View {
        Squircle()
            .frame(width: iconSize, height: iconSize)
            .foregroundStyle(.background)
            .overlay {
                Squircle().stroke(.quaternary, lineWidth: 1)
            }
            .overlay(alignment: .center) {
                Circle()
                    .foregroundStyle(accentColor.color.gradient)
                    .frame(width: 12, height: 12)
            }
    }

    var body: some View {
        List {
            Section("Theme") {
                ActionToggle(isOn: $matchSystem) {
                    Text("Match System")
                } action: { newValue in
                    if newValue == true {
                        colorScheme = .match
                    }
                }

                Picker(selection: $colorScheme) {
                    Label {
                        Text("Light")
                    } icon: {
                        smallThemePreview()
                            .environment(\.colorScheme, .light)
                    }
                    .tag(ColorSchemeChoice.light)

                    Label {
                        Text("Dark")
                    } icon: {
                        smallThemePreview()
                            .environment(\.colorScheme, .dark)
                    }
                    .tag(ColorSchemeChoice.dark)
                } label: {
                    Text("Theme")
                }
                .labelsHidden()
                .pickerStyle(.inline)

            }

            Section("Accent") {
                Picker(selection: $accentColor) {
                    ForEach(LabeledColor.gemstones) { labeledColor in
                        Label {
                            Text(labeledColor.name)
                        } icon: {
                            Squircle()
                                .overlay {
                                    Squircle()
                                        .stroke(.background, lineWidth: (accentColor == labeledColor ? 2 : 0))
                                }
                                .frame(width: iconSize, height: iconSize)
                                .shadow(color: labeledColor.color, radius: 2, x: 0, y: 0)
                                .foregroundStyle(labeledColor.color.gradient)
                        }
                        .tag(labeledColor)
                    }
                } label: {
                    Text("Accent Color")
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }

            Section {
                rainbow.listRowInsets(EdgeInsets())
            }
        }
        .preferredColorScheme(colorSchemeToUse)
    }
}

struct MBColorSchemeAccentPicker_Previews: PreviewProvider {
    static var previews: some View {
        MBColorSchemeAccentPicker()
    }
}
