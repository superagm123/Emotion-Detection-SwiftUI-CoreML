//
//  SettingsView.swift
//  EmotionDetection
//
//  Created by Alfonso Gonzalez Miramontes on 30/08/25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isSettingsActive: Bool
    
    var body: some View {
        GeometryReader {proxy in
            let size = proxy.size
            
            let isLandscape = size.width > size.height
            
            VStack {
                HStack{
                    Text("Settings")
                        .font(.title2)
                    
                    Spacer(minLength: 1)
                    
                    Button(action: {
                        withAnimation {
                            isSettingsActive.toggle()
                        }
                    }) {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                            .foregroundStyle(.gray)
                    }
                }
                .padding()
                
                ScrollView{
                    Section("Appearance"){
                        ThemeToggleView()
                    }
                }
            }
            .frame(width: isLandscape ? size.width * 0.5 : size.width * 0.8, height:  isLandscape ? size.height * 0.8 : size.height * 0.4)
            .background(.thinMaterial, in: .rect(cornerRadius: 12))
            .shadow(radius: 1)
            .position(x: size.width / 2, y: size.height / 2)
        }
    }
}

#Preview {
    ThemeSwitcher{
        SettingsView(isSettingsActive: .constant(true))
    }
}
