import SwiftUI

extension Color {
    static func trademateAccent(for scheme: ColorScheme) -> Color {
        scheme == .dark ? trademateAccentDark : trademateAccentLight
    }
    
    static let trademateAccentDark = Color(UIColor.systemYellow)
    static let trademateAccentLight = Color(UIColor.systemOrange)
    static let trademateRed = Color(UIColor.systemRed)
    static let trademateGreen = Color(UIColor.systemGreen)
}


