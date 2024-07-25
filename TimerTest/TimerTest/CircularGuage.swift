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
    var size: CGFloat = 200
    
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
            
            Text("\(Int((progress / maxProgress) * 100))%")
                .font(.largeTitle)
                .bold()
        }
    }
}

struct CircularGauge_Previews: PreviewProvider {
    static var previews: some View {
        CircularGauge(progress: 0.75)
    }
}
