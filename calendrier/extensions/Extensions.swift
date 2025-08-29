//
//  ColorExtensions.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-25.
//

import SwiftUI

extension Color {
    static let darkGrayBackground = Color(red: 27/255, green: 27/255, blue: 27/255)     // #1B1B1B
    static let deepBlueAccent     = Color(red: 34/255, green: 0/255,  blue: 206/255)    // #2200CE
    static let brightYellow       = Color(red: 255/255, green: 217/255, blue: 0/255)    // #FFD900
    static let softYellow         = Color(red: 255/255, green: 242/255, blue: 171/255)  // #FFF2AB
    static let offWhite           = Color(red: 250/255, green: 250/255, blue: 250/255)  // #FAFAFA
    static let softCream = Color(red: 255/255, green: 250/255, blue: 234/255)
}

extension UIColor {
    static let softCream = UIColor(red: 255/255, green: 250/255, blue: 234/255, alpha: 1)
}

extension Font.TextStyle {
    func toUIFontTextStyle() -> UIFont.TextStyle {
        switch self {
        case .largeTitle: return .largeTitle
        case .title: return .title1
        case .title2: return .title2
        case .title3: return .title3
        case .headline: return .headline
        case .subheadline: return .subheadline
        case .body: return .body
        case .callout: return .callout
        case .footnote: return .footnote
        case .caption: return .caption1
        case .caption2: return .caption2
        @unknown default: return .body
        }
    }
}


extension Font {
    static func DMSansS(_ size: CGFloat) -> Font {
        return .custom("DMSans-9ptRegular", size: size)
    }
   
}


extension Font {
    static func DMSans(_ style: TextStyle) -> Font {
        return .custom("DMSans-9ptRegular", size: UIFont.preferredFont(forTextStyle: style.toUIFontTextStyle()).pointSize, relativeTo: style)
    }
}


