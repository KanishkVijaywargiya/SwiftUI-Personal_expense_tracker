//
//  HapticManager.swift
//  ExpenseEase
//
//  Created by Kanishk Vijaywargiya on 16/04/23.
//

import SwiftUI

class HapticManager: ObservableObject {
    func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}
