//
//  Comparable+Extension.swift
//  ExpenseEase
//
//  Created by Kanishk Vijaywargiya on 16/04/23.
//

import Foundation
import SwiftUI

extension Comparable {
    func clamp<T: Comparable>(lower: T, _ upper: T) -> T {
        return min(max(self as! T, lower), upper)
    }
}
