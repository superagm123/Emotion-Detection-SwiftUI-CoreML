//
//  ThemeSwitcher.swift
//  EmotionDetection
//
//  Created by Alfonso Gonzalez Miramontes on 30/08/25.
//

import SwiftUI

struct ThemeSwitcher<Content: View>: View {
    @ViewBuilder var content: Content
    @AppStorage("AppTheme") private var selectedTheme: AppTheme = .system
    
    var body: some View {
        content
            .preferredColorScheme(selectedTheme.colorScheme)
    }
}
