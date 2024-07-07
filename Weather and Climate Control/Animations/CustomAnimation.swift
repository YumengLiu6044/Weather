//
//  CustomAnimation.swift
//  Weather
//
//  Created by Yumeng Liu on 7/7/24.
//

import Foundation
import SwiftUI

struct AnimatedLinearGradient: View {
    @Binding var isDay: Bool

    var body: some View {
        LinearGradient(colors: [isDay ? .blue : .black, isDay ? .blue.opacity(0.5) : .black.opacity(0.5)], startPoint: .top, endPoint: .bottom)
            .animation(.easeInOut(duration: 1), value: isDay)
    }
}

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))}
    
    static func blurReplace() -> AnyTransition {
        AnyTransition.opacity.combined(with: .opacity)
    }
}
