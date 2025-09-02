//
//  ContentView.swift
//  EmotionDetection
//
//  Created by Alfonso Gonzalez Miramontes on 30/08/25.
//

import SwiftUI
import PhotosUI
import CoreML

struct MainScreen: View {
    @State private var isSettingsViewActive: Bool = false
    @State private var selectedImage: UIImage? = nil
    @State private var probs: [String:Double] = [: ]
    
    private let model: EmotionDetection = try! EmotionDetection(configuration: MLModelConfiguration())
    
    private var sortedProbs: [Dictionary<String, Double>.Element] {
        let array = Array(probs)
        
        return array.sorted{lhs, rhs in
            lhs.value > rhs.value
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                VStack(spacing: 25){
                    PhotosPickerView(selectedImage: $selectedImage, probs: $probs)
                    
                    Button("Detect"){
                        if selectedImage != nil {
                            performDetection()
                        }
                    }
                    .buttonStyle(.bordered)
                    .font(.title)
                    .foregroundStyle(.green)
                    
                    
                    EmotionListView(probs: sortedProbs)
                }
                .blur(radius: isSettingsViewActive ? 10 : 0)
    
                Group {
                    if isSettingsViewActive {
                        SettingsView(isSettingsActive: $isSettingsViewActive)
                            .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    }
                }
                
            }
            .navigationTitle(isSettingsViewActive ? "" : "Emotion Detection")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        withAnimation {
                            isSettingsViewActive.toggle()
                        }
                    }){
                        Image(systemName: "gearshape.fill")
                            .imageScale(.large)
                            .font(.title3)
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func EmotionListView(probs: [Dictionary<String, Double>.Element]) -> some View {
        List{
            ForEach(probs, id: \.key){key, value in
                HStack {
                    Text(key)
                    Spacer(minLength: 1)
                    Text(value as NSNumber, formatter: NumberFormatter.percentage)
                }
            }
        }
        .listStyle(.plain)
    }
    
    private func performDetection(){
        guard let resizedImage = selectedImage?.resize(to: CGSize(width: 299, height: 299)) else { return }
        
        guard let buffer = resizedImage.toCVPixelBuffer() else { return }
        
        do {
            let result = try model.prediction(image: buffer)
            
            probs = result.targetProbability
        }catch {
            print(error.localizedDescription)
        }
    }
}



#Preview {
    ThemeSwitcher{
        MainScreen()
    }
}
