//
//  EmotionDetectionApp.swift
//  EmotionDetection
//
//  Created by Alfonso Gonzalez Miramontes on 30/08/25.
//

import SwiftUI

@main
struct EmotionDetectionApp: App {
    var body: some Scene {
        WindowGroup {
            ThemeSwitcher{
                MainScreen()
            }
        }
    }
}
