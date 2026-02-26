//
//  Font+Typewriter.swift
//  WeatherNotes
//

import SwiftUI

extension Font {
    static func typewriter(_ style: Font.TextStyle = .body) -> Font {
        .system(style, design: .monospaced)
    }
}
