//
//  Date+Extantions.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 12.05.2023.
//

import Foundation
import UIKit

extension Date {
    func formatDAte() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ka_GE")
        formatter.dateFormat = "MMMM d,HH:mm"
        return formatter.string(from: self)
    }
}
