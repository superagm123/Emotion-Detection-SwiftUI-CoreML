//
//  PhotosPickerView.swift
//  EmotionDetection
//
//  Created by Alfonso Gonzalez Miramontes on 01/09/25.
//

import SwiftUI
import PhotosUI

struct PhotosPickerView: View {
    @Binding var selectedImage: UIImage?
    @Binding var probs: [String:Double]
    @State private var selectedItem: PhotosPickerItem? = nil
    
    private let shadowColor: Color = .black.opacity(0.3)
    private let shadowRadius: CGFloat = 2
    
    var body: some View {
        ZStack {
            if selectedImage == nil {
                Image(systemName: "photo.circle.fill")
                    .imageScale(.large)
                    .font(.system(size: 150))
                    .foregroundStyle(.green, .white)
                    .shadow(color: shadowColor, radius: shadowRadius)
                    
            }else {
                if let selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(.circle)
                        .shadow(color: shadowColor, radius: shadowRadius)
                }
            }
        }
        .overlay(alignment: .bottomTrailing){
            if selectedImage == nil {
                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()){
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                        .font(.system(size: 50))
                        .foregroundStyle(.white, .green)
                        .shadow(color: shadowColor, radius: shadowRadius)
                        .padding(2)
                }
                .onChange(of: selectedItem){oldValue, newValue in
                    newValue?.loadTransferable(type: Data.self){result in
                        switch result {
                        case .success(let data):
                            if let data {
                                guard let image = UIImage(data: data) else { return }
                                
                                selectedImage = image
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            }else {
                Button(action: {
                    withAnimation{
                        selectedItem = nil
                        selectedImage = nil
                        probs = [:]
                    }
                }){
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                        .font(.system(size: 50))
                        .foregroundStyle(.white, .red)
                        .padding(-10)
                        .shadow(color: shadowColor, radius: shadowRadius)
                }
            }
        }
    }
}

#Preview {
    PhotosPickerView(selectedImage: .constant(nil), probs: .constant([:]))
}
