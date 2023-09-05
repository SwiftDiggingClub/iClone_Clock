//
//  StopWatchObservable.swift
//  iClone_Clock
//
//  Created by Seungui Moon on 2023/09/04.
//

import Foundation

class StopWatchObservable: ObservableObject {
    @Published var minute = 0
    @Published var second  = 0
    @Published var milliSecond = 0
    @Published var lapTimeList: [LapTime] = []
    @Published private var timeCount: Double = 0.0
    
    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
 
    func startCounting(){
        timeCount += 0.1
        minute = Int((timeCount/60).truncatingRemainder(dividingBy: 60))
        second = Int(timeCount.truncatingRemainder(dividingBy: 60))
        milliSecond = Int((timeCount*10).truncatingRemainder(dividingBy: 10))
    }
    
    func stopCounting(){
        timer.upstream.connect().cancel()
    }
    
    func setTimer(){
        timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    }
    
    func resetStopWatch(){
        timeCount = 0
        minute = 0
        second = 0
        milliSecond = 0
        lapTimeList.removeAll()
    }
    
    func addLapTime(){
        let newLapTime = LapTime(lapCount: lapTimeList.count + 1, minute: minute, second: second, milliSecond: milliSecond)
        lapTimeList.append(newLapTime)
    }
}
