//
//  NumberFormatter+Extension.swift
//  EmotionDetection
//
//  Created by Alfonso Gonzalez Miramontes on 01/09/25.
//

import Foundation

extension NumberFormatter {
    static var percentage: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
}
