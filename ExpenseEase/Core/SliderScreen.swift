//
//  SliderScreen.swift
//  ExpenseEase
//
//  Created by Kanishk Vijaywargiya on 15/04/23.
//

import SwiftUI
import CoreMotion

struct SliderScreen: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @StateObject private var motionManager = MotionManager()
    @State private var position = CGPoint.zero
    @State private var showSlider: Bool = true
    
    var body: some View {
        ZStack {
            if authManager.isAuthenticated {
                HomeView()
            } else {
                VStack {
                    imageView
                    
                    descriptionArea
                }
            }
        }
        .onAppear {
            motionManager.fetchMotionData()
        }
        .onChange(of: authManager.errorDescription) { newValue in
            if let _ = newValue {
                showSlider = true
            }
        } /// this is for bringing back the slider
        .darkBackground()
        .edgesIgnoringSafeArea(.all)
    }
}

struct SliderScreen_Previews: PreviewProvider {
    static var previews: some View {
        SliderScreen()
            .environmentObject(AuthenticationManager())
    }
}

/// image view & description area
extension SliderScreen {
    private var imageView: some View {
        GeometryReader { geo in
            let size = geo.size
            Image("banner01")
                .frame(width: size.width * 2, height: size.height * 2)
                .frame(width: size.width, height: size.height)
                .ignoresSafeArea()
        }
        .offset(motionManager.movingOffset)
    }
    
    private var descriptionArea: some View {
        VStack (alignment: .center, spacing: 0) {
            Text("Manage your daily expenses")
                .font(.title2.bold())
                .foregroundColor(.primary)
            
            HStack {
                Text("with").font(.title2.bold()).foregroundColor(.primary)
                Text("ExpenseEase")
                    .font(.largeTitle.bold())
                    .textForground()
            } /// gradient text
            
            VStack (spacing: 50) {
                Text("ExpenseEase offers a complete expense tracking solution that enables you to effortlessly monitor all of your expenses and export them to PDF format.")
                    .font(.headline)
                    .foregroundColor(Color(hex: "92BAFE"))
                    .multilineTextAlignment(.center)
            }.padding() /// content text
            
            Spacer()
            
            /// slider button with haptic & biometric system
            if showSlider {
                SliderButton()
                    .onSwipeSuccess {
                        Task {
                            await authManager.authenticateWithBiometrics()
                        }
                        showSlider = false
                    }
            } else if !showSlider {
                ProgressView()
                    .transition(AnyTransition.scale.animation(Animation.spring(response: 0.5, dampingFraction: 0.5)))
                    .tint(
                        LinearGradient(
                            colors: [
                                Color(hex: "02D5FF"),
                                Color(hex: "C84CFF")
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .onDisappear {
                        authManager.errorDescription = nil
                    }
                //                    .onAppear {
                //                        if !authManager.isAuthenticated {
                //                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                //                                self.showSlider = true
                //                            }
                //                        }
                //                    }
            }
        }
        .padding(.top, 40)
        .padding(.bottom, 40) /// home screen content
    }
}
