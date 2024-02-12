//
//  reColorButtonStyle.swift
//  reMind
//
//  Created by Pedro Sousa on 03/07/23.
//

import SwiftUI

struct reColorButtonStyle: ButtonStyle {
    private var theme: reTheme
    private var opacity: Double

    init(_ theme: reTheme, _ opacity: Double = 1) {
        self.theme = theme
        self.opacity = opacity
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.body)
            .fontWeight(.bold)
            .foregroundColor(Palette.reBlack.render.opacity(opacity))
            .frame(height: 48)
            .background {
                Rectangle()
                    .fill(theme.render)
                    .cornerRadius(10)
            }
    }
}
