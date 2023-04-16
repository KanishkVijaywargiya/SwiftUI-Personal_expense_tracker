//
//  TextForeground.swift
//  ExpenseEase
//
//  Created by Kanishk Vijaywargiya on 16/04/23.
//

import SwiftUI

struct TextBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(
                .linearGradient(
                    colors: [
                        Color(hex: "02D5FF"),
                        Color(hex: "C84CFF")
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }
}


extension View {
    func textForground() -> some View {
        modifier(TextBackground())
    }
}

