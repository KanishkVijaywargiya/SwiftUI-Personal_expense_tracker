//
//  InstaQRCodeUI.swift
//  ExpenseEase
//
//  Created by Kanishk Vijaywargiya on 17/04/23.
//

import SwiftUI

struct InstaQRCodeUI: View {
    @State private var showEmojiPicker: Bool = false
    @State private var defaultEmoji = "😀"
    
    var body: some View {
        GeometryReader { geometry in
            let availableHeight = geometry.size.height - geometry.safeAreaInsets.top - geometry.safeAreaInsets.bottom
            let rowHeight = availableHeight / CGFloat(10)
            
            VStack (spacing: 10) {
                ForEach(0..<10) { row in
                    HStack (spacing: 10) {
                        ForEach(0..<6) { column in
                            let hideEmoji = (row + column) % 2 == 0
                            let angle = getRotationAngle(row: row, column: column)
                            
                            if hideEmoji {
                                Text(defaultEmoji)
                                    .font(.system(size: 50))
                                    .frame(width: rowHeight, height: rowHeight)
                                    .rotationEffect(.degrees(angle))
                                    .onTapGesture {
                                        showEmojiPicker.toggle()
                                    }
                            } else {
                                Color.clear
                            }
                        }
                    }
                }
            }
        }
        .background(Color.white).ignoresSafeArea()
        .sheet(isPresented: $showEmojiPicker) {
            EmojiSelectionView(selectedEmoji: $defaultEmoji)
        }
    }
    
    func getRotationAngle(row: Int, column: Int) -> Double {
        switch (row, column) {
        case (0, 0), (0, 2), (1, 1), (2, 0), (2, 2), (3, 1), (4, 0), (5, 1), (6, 0), (6, 2), (7,1), (8, 0), (8, 2):
            return 30
        case (0, 2), (1, 3), (2, 0), (2, 2), (3, 1), (4, 2):
            return -30
        default:
            return 0
        }
    }
}

/// emoji picker ui for sheet
struct EmojiSelectionView: View {
    @Binding var selectedEmoji: String
    @Environment(\.dismiss) var dismissMode
    let columns = [GridItem(.adaptive(minimum: 80))]
    let emojis = ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "🥲", "☺️", "😊", "😇", "🙂", "🙃", "😉", "😌", "😍", "🥰", "😘", "😗", "😙", "😚", "😋", "😛", "😝", "❤️", "💛", "💚", "💙", "💜", "🖤", "🤍", "🤎", "❣️", "💕", "💞", "💓", "💗", "💖", "💘", "💝"]
    
    
    
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(emojis, id: \.self) { emoji in
                        Text(emoji)
                            .font(.system(size: 40))
                            .onTapGesture {
                                selectedEmoji = emoji
                                dismissMode()
                            }
                    }
                }
                .padding()
            }
        }
    }
}


struct InstaQRCodeUI_Previews: PreviewProvider {
    static var previews: some View {
        InstaQRCodeUI()
    }
}


