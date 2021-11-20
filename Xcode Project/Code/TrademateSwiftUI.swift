import SwiftUI

extension Color {
    
    static var systemRed: Color {
        #if os(macOS)
        return Color(NSColor.systemRed)
        #elseif os(iOS)
        return Color(UIColor.systemRed)
        #endif
    }
    
    static var systemGreen: Color {
        #if os(macOS)
        return Color(NSColor.systemGreen)
        #elseif os(iOS)
        return Color(UIColor.systemGreen)
        #endif
    }
    
    static var grayedOut: Color {
        #if os(macOS)
        return Color(NSColor.systemGray)
        #elseif os(iOS)
        return Color(UIColor.systemGray3)
        #endif
    }
}
