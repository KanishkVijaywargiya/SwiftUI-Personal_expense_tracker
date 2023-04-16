//
//  DarkBackground.swift
//  ExpenseEase
//
//  Created by Kanishk Vijaywargiya on 16/04/23.
//

import SwiftUI

struct DarkBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background {
                LinearGradient(
                    colors: [
                        Color(hex: "06122F"),
                        Color(hex: "17131A"),
                        Color(hex: "13131F"),
                        Color(hex: "212739")
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
    }
}


extension View {
    func darkBackground() -> some View {
        modifier(DarkBackground())
    }
}
