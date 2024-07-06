//
//  GaugeRowView.swift
//  Weather
//
//  Created by Yumeng Liu on 7/6/24.
//

import Foundation
import SwiftUI

struct GaugeRow: View {
    
    var gaugeData: GaugeData
    
    var offset: CGFloat {
        let offset = (gaugeData.minimunTrackValue - gaugeData.minimunValue) / (gaugeData.maximimValue - gaugeData.minimunValue)
        return offset
    }
    
    var gaugeWidth: CGFloat {
        let max = (gaugeData.maximimTrackValue - gaugeData.minimunValue) / (gaugeData.maximimValue - gaugeData.minimunValue)
        let min = (gaugeData.minimunTrackValue - gaugeData.minimunValue) / (gaugeData.maximimValue - gaugeData.minimunValue)
        return max - min
    }
    
    var body: some View {
        HStack {
            Text("\(Int(gaugeData.minimunTrackValue))°")
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.trailing)
                .padding(.trailing, 5)
                
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    GaugeBackgroundView()
                    GaugeView(gaugeData: gaugeData)
                        .frame(width: gaugeWidth * proxy.size
                                .width)
                        .offset(x: proxy.size.width * offset)
                }
            }
            .frame(height: 10.0)
            Text("\(Int(gaugeData.maximimTrackValue))°")
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .frame(alignment: .leading)
                .padding(.leading, 5)
        }
    }
}

#Preview {
    GaugeRow(gaugeData: sampleGaugeData)
}
