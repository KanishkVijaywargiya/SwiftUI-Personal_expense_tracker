//
//  CGSize+Extension.swift
//  ExpenseEase
//
//  Created by Kanishk Vijaywargiya on 16/04/23.
//

import Foundation
import SwiftUI

extension CGSize {
    static var inactiveThumbSize: CGSize {
        return CGSize(width: 70, height: 50)
    }
    
    static var trackSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 50)
    }
    
    static var activeThumbSize: CGSize {
        return CGSize(width: 85, height: 50)
    }
}
