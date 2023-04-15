//
//  MotionManager.swift
//  ExpenseEase
//
//  Created by Kanishk Vijaywargiya on 15/04/23.
//

import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
    @Published var motionManager = CMMotionManager()
    
    /// storing motion data to animate view in parallax.
    ///  Role -> X axis & Pitch -> Y axis
    @Published var xValue: CGFloat = 0
    @Published var yValue: CGFloat = 0
    
    /// moving offset
    @Published var movingOffset: CGSize = .zero
    
    func fetchMotionData() {
        motionManager.startDeviceMotionUpdates(to: .main) { data, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            
            /// animation using time curve
            withAnimation (.timingCurve(0.18, 0.78, 0.18, 1, duration: 0.77)) {
                self.xValue = data.attitude.roll
                self.yValue = data.attitude.pitch
                self.movingOffset = self.getOffset(duration: 30)
            }
        }
    }
    
    func getOffset(duration: CGFloat) -> CGSize {
        var width = xValue * 30
        var height = yValue * 30
        
        width = (
            width < 0 ?
            (-width > 30 ? -30 : width) :
                (-width > 30 ? 30 : width)
        )
        
        height = (
            height < 0 ?
            (-height > 30 ? -30 : height) :
                (-height > 30 ? 30 : height)
        )
        
        /// avoiding if views goes over duration
        
        return CGSize(width: width, height: height)
    }
}
