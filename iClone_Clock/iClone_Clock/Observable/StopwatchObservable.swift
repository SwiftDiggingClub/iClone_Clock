//
//  StopwatchObservable.swift
//  iClone_Clock
//
//  Created by hyunjun on 2023/09/04.
//

import Foundation
import SwiftUI
import Combine

class StopwatchObserable: ObservableObject {
    
    @Published var counter = 0
    @Published var laps: [Int] = []
    /// Combine 스트림을 구독할 때 AnyCancellable 객체로 초기화
    /// 뷰가 해제될 때 Combine 스트림의 구독을 취소해야 함 - 메모리 누수 방지
    
    private var timer: AnyCancellable?
    
    func startTimer() {
        timer = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.counter += 1
            }
    }
    
    func stopTimer() {
        /// 옵셔널 체이닝, nil 이 아닌 경우에만 호출
        timer?.cancel()
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


extension StopwatchObserable {
    
    /// 0.01 초 단위로 올라간 숫자를 00:00:00 타이머 형태로 변환해주는 함수입니다.
    /// - Parameter counter: Int 값을 넣어주세요
    /// - Returns: 00:00:00 타이머 형태
    func formattedTime(_ counter: Int) -> String {
        let minutes = counter / 6000
        let seconds = counter / 100 % 60
        let milliseconds = counter % 100
        
        return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
    }
    
    /// 최대 최솟값을 판별하여 색상을 넣어줍니다.
    /// - Parameter lap: 랩
    /// - Returns: 색상
    func lapColor(_ lap: Int) -> Color {
        let maxLap = laps.max() ?? 0
        let minLap = laps.min() ?? 0
        
        switch (lap == minLap, lap == maxLap) {
        case (true, true):
            return Color.primary
        case (_, true):
            return Color.red
        case (true, _):
            return Color.green
        default:
            return Color.primary
        }
    }
}
