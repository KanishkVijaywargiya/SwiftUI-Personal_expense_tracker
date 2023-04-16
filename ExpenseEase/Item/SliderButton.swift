//
//  SliderButton.swift
//  ExpenseEase
//
//  Created by Kanishk Vijaywargiya on 16/04/23.
//

import SwiftUI

struct SliderButton: View {
    /// we need to keep track of the dragging value. Initially it's zero
    @State private var dragOffset: CGSize = .zero
    /// we want to animate the thumb size when user starts dragging ( swipe )
    @State private var thumbSize: CGSize = CGSize.inactiveThumbSize
    /// keep track of when enough was swipped
    @State private var isEnough: Bool = false
    let trackSize = CGSize.trackSize
    private var actionSuccess: (()->())?
    
    var body: some View {
        ZStack {
            /// swipe track
            Capsule()
                .frame(width: trackSize.width , height: trackSize.height)
                .foregroundColor(Color(hex: "06122F"))
            
            Text("Swipe to Unlock")
                .fontWeight(.semibold)
                .opacity(Double(1 - ( (self.dragOffset.width * 2) / self.trackSize.width )))
                .shimmer(.init(tint: Color(hex: "92BAFE").opacity(0.5), highlight: .white, blur: 5))
            
            /// thumb
            ZStack {
                Capsule()
                    .frame(width: thumbSize.width, height: thumbSize.height)
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
                Image(systemName: "chevron.right.2").font(.system(size: 25))
                    .foregroundColor(.white)
            }
            .offset(x: getDragOffsetX(), y: 0)
            .animation(Animation.spring(response: 0.3, dampingFraction: 0.8), value: dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { value in self.handleDragChanged(value) }
                    .onEnded { _ in self.handleDragEnded() }
            )
        }
    }
}

struct SliderButton_Previews: PreviewProvider {
    static var previews: some View {
        SliderButton()
    }
}


extension SliderButton {
    func onSwipeSuccess(_ action: @escaping() -> ()) -> Self {
        var this = self
        this.actionSuccess = action
        print(action)
        return this
      }
    
    /// Haptics Feedback
    private func indicateCanLiftFinger() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    private func indicateSwipeWasSuccessful() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    private func getDragOffsetX() -> CGFloat {
        let clampedDragOffsetX = dragOffset.width.clamp(lower: 0, trackSize.width - thumbSize.width)
        return -( trackSize.width / 2 - thumbSize.width / 2 - (clampedDragOffsetX) )
    }
    
    private func handleDragChanged(_ value: DragGesture.Value) -> () {
        self.dragOffset = value.translation
        
        let dragWidth = value.translation.width
        let targetDragWidth = self.trackSize.width - ( self.thumbSize.width * 2 )
        let wasInitiated = dragWidth > 2
        let didReachTarget = dragWidth > targetDragWidth
        
        self.thumbSize = wasInitiated ? CGSize.activeThumbSize : CGSize.inactiveThumbSize
        
        if didReachTarget {
            // only trigger once
            if !self.isEnough {
                self.indicateCanLiftFinger()
            }
            // we need to indicate something here
            self.isEnough = true
        } else {
            // reset, do not indicate here
            self.isEnough = false
        }
    }
    
    private func handleDragEnded() {
        if self.isEnough {
            self.dragOffset = CGSize(width: self.trackSize.width - self.thumbSize.width, height: 0)
            
            if self.actionSuccess != nil {
                self.indicateSwipeWasSuccessful()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.actionSuccess!()
                }
            }
        } else {
            self.dragOffset = .zero
            self.thumbSize = CGSize.inactiveThumbSize
        }
    }
}
