//
//  HeaderView.swift
//  Sennight
//
//  Created by ksy on 7/2/24.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    @State private var startTime: Date? = nil
    @State private var currentTime: Date = Date()
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            Text(elapsedTimeString)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            HStack {
                Button(action: {
                    self.startTime = Date()
                    self.timer?.invalidate()//기존 타이머 무효화
                    self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        self.currentTime = Date()
                    }
                }, label: {
                    Text("시작")
                })
                Button(action: {
                    self.timer?.invalidate()
                }, label: {
                    Text("중지")
                })
                Button(action: {
                    self.timer?.invalidate()
                    self.startTime = nil
                    self.currentTime = Date()
                }, label: {
                    Text("재시작")
                })
            }
        }
    }
    
    var elapsedTimeString: String {
        guard let startTime = startTime else { return "00년 00월 00일 00:00:00" }
        return currentTime.timeElapsed(since: startTime)
    }
}

#Preview {
    HeaderView()
}

extension Date {
    func timeElapsed(since startTime: Date) -> String {
        let calender = Calendar.current
        let components = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: startTime, to: self)
        
        let years = components.year ?? 0
        let months = components.month ?? 0
        let days = components.day ?? 0
        let hour = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        return String(format: "%02d년 %02d월 %02d일 %02d:%02d:%02d", years, months, days, hour, minutes, seconds)
    }
}
