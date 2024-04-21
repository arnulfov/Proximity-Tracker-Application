//
//  RSSIndicator.swift
//  Proximity Tracker
//
//  Created by user238598 on 4/2/24.
//

import SwiftUI

struct SmallRSSIIndicator: View {
    
    @Environment(\.colorScheme) var colorScheme
    let rssi: Double
    let bestRSSI: Double
    
    var body: some View {
        
        let quality: Int = Int(floor(4 * rssiToPercentage(rssi: rssi, bestRSSI: bestRSSI)))
        
        let size: CGFloat = 15
        
        HStack(spacing: size/10) {
            
            let minHeight = 0.4
            let step = (1-minHeight)/4
            
            ForEach(0..<4, id: \.self) { index in
                
                let active = quality >= index && rssi > Constants.worstRSSI
                
                SmallRSSIIndicatorLine(height: size * (minHeight + step*Double(index)), size: size)
                    .opacity(active ? 1 : 0.5)
                    .animation(.easeInOut, value: active)
            }
            
        }
        .offset(y: -size * 0.1)
        .frame(height: size)
        .foregroundColor(Color.accentColor.opacity(colorScheme.isLight ? 0.8 : 1))
    }
}


struct SmallRSSIIndicatorLine: View {
    
    let height: CGFloat
    let size: CGFloat
    
    var body: some View {
        
            RoundedRectangle(cornerRadius: size/3)
            .frame(width: size/4, height: height)
            .frame(height: size, alignment: .bottom)
    }
}

struct Previews_RSSIIndicator_Previews: PreviewProvider {
    static var previews: some View {
        SmallRSSIIndicator(rssi: -100, bestRSSI: -30)
    }
}
