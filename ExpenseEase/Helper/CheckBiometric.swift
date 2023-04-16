//
//  CheckBiometric.swift
//  ExpenseEase
//
//  Created by Kanishk Vijaywargiya on 16/04/23.
//

import LocalAuthentication

extension LAContext {
    enum BiometricType: String {
        case none
        case touchID = "Touch ID"
        case faceID = "Face ID"
    }
    
    var biometricType: BiometricType {
        var error: NSError?
        
        guard self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            // Capture these recoverable error thru Crashlytics
            return .none
        }
        
        if #available(iOS 13.0, *) {
            switch self.biometryType {
            case .none:
                return .none
            case .touchID:
                return .touchID
            case .faceID:
                return .faceID
            @unknown default:
                return .none
            }
        } else {
            return self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
        }
    }
}
