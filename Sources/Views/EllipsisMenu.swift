//
//  EllipsisMenu.swift
//  
//
//  Created by Matt Bonney on 12/7/22.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
/// A default SwiftUI `Menu` with it's Label pre-set to the `ellipsis.circle` SF Symbol.
public struct EllipsisMenu<Content: View>: View {
    let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        Menu {
            content()
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }
}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
/// Places a MBUtilities `EllipsisMenu` in the NavigationBar's `.navigationBarTrailing` position.
public struct ToolbarEllipsisMenu<MenuContent: View>: ToolbarContent {
    let menuContent: () -> MenuContent

    let placement: ToolbarItemPlacement = {
        #if os(macOS)
        ToolbarItemPlacement.automatic
        #else
        ToolbarItemPlacement.navigationBarTrailing
        #endif
    }()

    public init(@ViewBuilder menuContent: @escaping () -> MenuContent) {
        self.menuContent = menuContent
    }

    public var body: some ToolbarContent {
        ToolbarItem(placement: self.placement) {
            EllipsisMenu(content: menuContent)
        }
    }
}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
struct EllipsisMenu_Previews: PreviewProvider {
    static var previews: some View {
        EllipsisMenu {
            Text("Menu Content Goes here.")
            Text("Even more menu content.")
        }
    }
}
