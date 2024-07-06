//
//  GuageBackgroundView.swift
//  Weather
//
//  Created by Yumeng Liu on 7/6/24.
//

import SwiftUI

struct GaugeBackgroundView: View {
    var body: some View {
        Capsule()
            .fill(.quaternary)
            .frame(height: 10.0)
    }
}

struct GaugeBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        GaugeBackgroundView()
    }
}
