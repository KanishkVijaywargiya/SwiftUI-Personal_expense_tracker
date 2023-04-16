//
//  SliderScreen.swift
//  ExpenseEase
//
//  Created by Kanishk Vijaywargiya on 15/04/23.
//

import SwiftUI
import CoreMotion

struct SliderScreen: View {
    @StateObject private var motionManager = MotionManager()
    @State private var position = CGPoint.zero
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                let size = geo.size
                Image("banner01")
                    .frame(width: size.width * 2, height: size.height * 2)
                    .frame(width: size.width, height: size.height)
                    .ignoresSafeArea()
            }
            .offset(motionManager.movingOffset)
            
            VStack (alignment: .center, spacing: 0) {
                Text("Manage your daily expenses")
                    .font(.title2.bold())
                    .foregroundColor(.primary)
                
                HStack {
                    Text("with").font(.title2.bold()).foregroundColor(.primary)
                    Text("ExpenseEase")
                        .font(.largeTitle.bold())
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
                } /// gradient text
                
                VStack (spacing: 50) {
                    Text("ExpenseEase offers a complete expense tracking solution that enables you to effortlessly monitor all of your expenses and export them to PDF format.")
                        .font(.headline)
                        .foregroundColor(Color(hex: "92BAFE"))
                        .multilineTextAlignment(.center)
                }.padding() /// content text
                
                Spacer()
                
                /// slider button with haptic & biometric system
                Text("Slider")
            }
            .padding(.top, 40)
            .padding(.bottom, 40) /// home screen content
        }
        .onAppear {
            motionManager.fetchMotionData()
        }
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
        .edgesIgnoringSafeArea(.all)
    }
}

struct SliderScreen_Previews: PreviewProvider {
    static var previews: some View {
        SliderScreen()
    }
}
