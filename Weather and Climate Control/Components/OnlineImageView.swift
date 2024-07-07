//
//  OnlineImageView.swift
//  Weather
//
//  Created by Yumeng Liu on 7/7/24.
//

import SwiftUI


struct OnlineImageView: View {
    var imageURL: String
    @Binding var isLoading: Bool
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL), transaction: Transaction(animation: .spring(response: 1, dampingFraction: 0.6, blendDuration: 0.5))) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 10)
                    .onAppear {
                        isLoading = false
                    }
                
            case .failure:
                Image(systemName: "questionmark.app")
                    .aspectRatio(contentMode: .fit)
                    .onAppear {
                        isLoading = false
                    }
                
            case .empty:
                ProgressView()
                    .onAppear {
                        isLoading = true
                    }
                
            @unknown default:
                EmptyView()
                    .onAppear {
                        isLoading = false
                    }
            }}
    }
}

#Preview {
    OnlineImageView(imageURL: "", isLoading: .constant(true))
}
