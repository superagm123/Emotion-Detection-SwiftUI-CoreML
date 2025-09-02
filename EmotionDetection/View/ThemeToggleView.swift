//
//  ThemeToggleView.swift
//  EmotionDetection
//
//  Created by Alfonso Gonzalez Miramontes on 30/08/25.
//

import SwiftUI

struct ThemeToggleView: View {
    @AppStorage("AppTheme") private var selectedTheme: AppTheme = .system
    
    var body: some View {
        HStack(spacing: 5){
            ForEach(Array(AppTheme.allCases.enumerated()), id: \.element.rawValue){index, theme in
                VStack(spacing: 12){
                    Image(systemName: theme.icon)
                        .imageScale(.large)
                    Text(theme.rawValue)
                        .font(.headline)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemBackground))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(selectedTheme == theme ? Color.green : Color.clear, lineWidth: 3)
                                .shadow(color: Color.accentColor.opacity(0.6), radius: 10)
                                .blur(radius: 1)
                        }
                )
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 4)
                .rotation3DEffect(
                    .degrees(selectedTheme == theme ? -10 : 0),
                    axis: (x: 1, y: 0, z: 0),
                    anchor: .bottom,
                    perspective: 0.5
                )
                .scaleEffect(selectedTheme == theme ? 1.0 : 0.9)
                .animation(.easeInOut(duration: 0.3), value: selectedTheme)
                .onTapGesture {
                    selectedTheme = theme
                }
            }
        }
        .padding()
    }

}

#Preview {
    ThemeSwitcher {
        ThemeToggleView()
    }
}
