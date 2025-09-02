//
//  AppTheme.swift
//  EmotionDetection
//
//  Created by Alfonso Gonzalez Miramontes on 30/08/25.
//

import Foundation
import SwiftUI

enum AppTheme: String, CaseIterable {
    case light = "Light"
    case dark = "Dark"
    case system = "System"
    
    var colorScheme: ColorScheme? {
        switch self {
        case .light: .light
        case .dark: .dark
        case .system: nil
        }
    }
    
    var icon: String {
        switch self {
        case .light: "sun.max.fill"
        case .dark: "moon.stars.fill"
        case .system: "arrow.trianglehead.2.clockwise"
        }
    }
}
