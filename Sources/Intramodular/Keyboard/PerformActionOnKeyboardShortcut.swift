//
// Copyright (c) Vatsal Manot
//

#if swift(>=5.3) && os(macOS)

import Swift
import SwiftUI

@available(OSX 10.16, tvOS 14.0, *)
@available(watchOS, unavailable)
@usableFromInline
struct PerformActionOnKeyboardShortcut: ViewModifier {
    let shortcut: KeyboardShortcut
    let action: () -> Void
    
    @usableFromInline
    init(shortcut: KeyboardShortcut, action: @escaping () -> ()) {
        self.shortcut = shortcut
        self.action = action
    }
    
    @available(iOS 14.0, OSX 10.16, tvOS 14.0, *)
    @available(watchOS, unavailable)
    @usableFromInline
    func body(content: Content) -> some View {
        ZStack {
            Button(action: action) {
                EmptyView()
            }
            .keyboardShortcut(shortcut)
            
            content
        }
    }
}

// MARK: - API -

extension View {
    /// Adds an action to perform when this view recognizes a keyboard shortcut.
    @available(OSX 10.16, tvOS 14.0, *)
    @available(watchOS, unavailable)
    @inlinable
    public func onKeyboardShortcut(
        _ shortcut: KeyboardShortcut,
        perform action: @escaping () -> Void
    ) -> some View {
        modifier(PerformActionOnKeyboardShortcut(shortcut: shortcut, action: action))
    }
    
    /// Adds an action to perform when this view recognizes a keyboard shortcut.
    @available(OSX 10.16, tvOS 14.0, *)
    @available(watchOS, unavailable)
    @inlinable
    public func onKeyboardShortcut(
        _ key: KeyEquivalent,
        modifiers: EventModifiers = [],
        perform action: @escaping () -> Void
    ) -> some View {
        modifier(PerformActionOnKeyboardShortcut(shortcut: .init(key, modifiers: modifiers), action: action))
    }
}

#endif
