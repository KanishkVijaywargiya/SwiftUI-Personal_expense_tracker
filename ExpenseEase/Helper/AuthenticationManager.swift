//
//  AuthenticationManager.swift
//  ExpenseEase
//
//  Created by Kanishk Vijaywargiya on 16/04/23.
//

import Foundation
import LocalAuthentication

class AuthenticationManager: ObservableObject {
    // this variable can only be set within this class
    private(set) var context = LAContext()
    private(set) var canEvaluatePolicy = false
    
    @Published private(set) var biometryType: LABiometryType = .none
    @Published private(set) var isAuthenticated: Bool = false
    @Published private(set) var errorDescription: String?
    @Published var showAlert: Bool = false
    
    init() {
        getBiometryType()
    }
    
    private func getBiometryType() {
        canEvaluatePolicy = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        biometryType = context.biometryType
    }
    
    func authenticateWithBiometrics() async {
        context = LAContext()
        
        if canEvaluatePolicy {
            let reason = "Log into your account"
            do {
                let success = try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason)
                
                if success {
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                        print("isAuthenticated--->", self.isAuthenticated)
                    }
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.errorDescription = error.localizedDescription
                    self.showAlert = true
                    self.biometryType = .none
                    print("errrooor---->", error)
                }
            }
        }
    }
}
