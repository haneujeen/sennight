import Foundation
import SwiftUI
import Combine

class MyTimer: ObservableObject {
    @Published var elapsed: TimeInterval = 0
    
    init() {
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.elapsed += 1
            self.objectWillChange.send()
        }
    }
}
