//
//  StopwatchObservable.swift
//  iClone_Clock
//
//  Created by hyunjun on 2023/09/04.
//

import Foundation
import SwiftUI

class StopwatchObserable: ObservableObject {
    
    @Published var counter = 0
    @Published var timer = Timer()
    @Published var laps: [Int] = []
    
    func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            self.counter += 1
        }
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func resetTimer() {
        self.counter = 0
        laps.removeAll()
    }
    
    func lapTimer() {
        laps.append(counter)
        self.counter = 0
    }
}
