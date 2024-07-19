//
//  MyTimer.swift
//  HealthProgressCardTest
//
//  Created by 한유진 on 7/19/24.
//

import SwiftUI
import Combine

@MainActor
final class MyTimer: ObservableObject {
    
    @Published var secondsElapsed = 0
    private var timer: Timer?
    private var frequency: TimeInterval
    private var startDate: Date?
    
    init(frequency: TimeInterval = 1) {
        self.frequency = frequency
    }
    
    func startTimer(startDate: Date?) {
        guard let startDate else { return }
        self.startDate = startDate
        timer?.invalidate()
        updateFrequency()
        timer = Timer.scheduledTimer(withTimeInterval: self.frequency, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            Task { @MainActor in
                self.update()
            }
        }
        timer?.tolerance = 0.1
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    private func update() {
        guard let startDate else { return }
        let elapsed = Int(Date().timeIntervalSince(startDate))
        self.secondsElapsed = elapsed
        updateFrequency()
    }
    
    private func updateFrequency() {
        let previousFrequency = self.frequency
        if secondsElapsed < 60 * 60 { // 1 hour
            self.frequency = 1 // 1 second
        } else if secondsElapsed < 72 * 60 * 60 { // 72 hours
            self.frequency = 60 // 1 minute
        } else if secondsElapsed < 365 * 24 * 60 * 60 { // 1 year
            self.frequency = 60 * 60 // 1 hour
        } else if secondsElapsed < 5 * 365 * 24 * 60 * 60 { // 5 years
            self.frequency = 24 * 60 * 60 // 1 day
        } else {
            self.frequency = 30 * 24 * 60 * 60 // 1 month
        }
        if previousFrequency != self.frequency {
            startTimer(startDate: self.startDate) // Restart the timer with the new frequency
        }
    }
}
