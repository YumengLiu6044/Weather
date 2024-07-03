//
//  LoadingView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/2/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(.linearGradient(colors: [.blue, .blue.opacity(0.5)], startPoint: .top, endPoint: .bottom))
                .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        }
        
    }
}

#Preview {
    LoadingView()
}
