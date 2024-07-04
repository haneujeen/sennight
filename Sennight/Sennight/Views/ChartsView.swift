//
//  ChartsView.swift
//  Sennight
//
//  Created by ksy on 7/4/24.
//

import SwiftUI
import Charts

struct ChartsView: View {
    let smokingData = [
        SampleData(week: "Mon", smoking: 1),
        SampleData(week: "Tue", smoking: 0),
        SampleData(week: "Wed", smoking: 0),
        SampleData(week: "Tau", smoking: 0),
        SampleData(week: "Fri", smoking: 3),
        SampleData(week: "Sat", smoking: 0),
        SampleData(week: "Sun", smoking: 1)
    ]
    
    var average : Double {
        let totalData = smokingData.reduce(0) { $0 + $1.smoking}
        return Double(totalData) / Double(smokingData.count)
    }
    
    var body: some View {
        VStack {
            Text("Smoking log")
                .font(.title)
                .padding()
            
            Chart(smokingData) { data in
                BarMark (
                    x: .value("week", data.week),
                    y: .value("smoking", data.smoking)
                )
                .foregroundStyle(.blue)
                
                RuleMark(y: .value("Average", average))
                    .foregroundStyle(.red)
                    .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                    .annotation(position: .top, alignment: .leading) {
                        Text("평균: \(average, specifier: "%.2f")")
                            .font(.caption)
                            .foregroundStyle(.red)
                            //.offset(x: 0, y: -10)
                            .chartXAxis {
                                AxisMarks(preset: .aligned, values: .automatic) { value in AxisValueLabel()
                                        .font(.footnote)
                                }
                            }
                    }
            }
            .frame(height: 500)
            
            
            
        }
    }
}

#Preview {
    ChartsView()
}
