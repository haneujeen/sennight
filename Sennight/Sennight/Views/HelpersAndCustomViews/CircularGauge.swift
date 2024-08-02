//
//  CircularGauge.swift
//  Sennight
//
//  Created by 한유진 on 6/28/24.
//

import SwiftUI

struct CircularGauge: View {
    var progress: Double
    var maxProgress: Double = 1.0
    var lineWidth: CGFloat = 20
    var gaugeColor: Color = .blue
    var backgroundColor: Color = .gray.opacity(0.2)
    var size: CGFloat = 130 // Circle size
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(backgroundColor)
                .frame(width: size, height: size)
            
            Circle()
                .trim(from: 0, to: CGFloat(progress / maxProgress))
                .stroke(gaugeColor, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: size, height: size)
            
            if progress == 1 {
                Text("100%")
                    .font(.largeTitle)
                    .bold()
            } else {
                Text(String(format: "%.1f%%", progress * 100))
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
            }
        }
    }
}

struct CircularGauge_Previews: PreviewProvider {
    static var previews: some View {
        CircularGauge(progress: 0.75)
    }
}
