import Foundation
import CoreGraphics

struct GaugeData: Identifiable {
    
    let id = UUID()
    
    var value: CGFloat?
    
    var minimunValue: CGFloat
    var maximimValue: CGFloat
    
    var minimunTrackValue: CGFloat
    var maximimTrackValue: CGFloat
    
}

func sampleGaugesData() -> [GaugeData] {
    var data: [GaugeData] = []
    data.append(contentsOf: [
        GaugeData(
            value: 24,
            minimunValue: 11,
            maximimValue: 32,
            minimunTrackValue: 11,
            maximimTrackValue: 24
        )
    ])
    return data
}

let sampleGaugeData = sampleGaugesData().first!
