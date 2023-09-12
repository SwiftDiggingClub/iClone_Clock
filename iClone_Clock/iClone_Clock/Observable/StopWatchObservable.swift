//
//  StopWatchObservable.swift
//  iClone_Clock
//
//  Created by Seungui Moon on 2023/09/04.
//

import Combine
import Foundation

class StopWatchObservable: ObservableObject {
    @Published var minute: Int = 0
    @Published var second: Int  = 0
    @Published var milliSecond: Int = 0
    @Published var lapTimeList: [LapTime] = []
    
    @Published private var timeCount: Double = 0.0
    
    @Published var minLapTime = LapTime(lapCount: -1, minute: 99, second: 99, milliSecond: 99)
    @Published var maxLapTime = LapTime(lapCount: -1, minute: 0, second: 0, milliSecond: 0)
    @Published var lapMinute: Int = 0
    @Published var lapSecond: Int  = 0
    @Published var lapMilliSecond: Int = 0
    @Published private var lapTimeCount: Double = 0.0
    
    private var timer: AnyCancellable?
    
    var formatedLapTime: String {
        String(format: "%02d:%02d:%02d", lapMinute, lapSecond, lapMilliSecond)
    }
    var formatedMainTime: String {
        String(format: "%02d:%02d:%02d", minute, second, milliSecond)
    }
 
    func startCounting(){
        timeCount += 0.01
        minute = Int((timeCount/60).truncatingRemainder(dividingBy: 60))
        second = Int(timeCount.truncatingRemainder(dividingBy: 60))
        milliSecond = Int((timeCount*100).truncatingRemainder(dividingBy: 100))
        
        lapTimeCount += 0.01
        lapMinute = Int((lapTimeCount/60).truncatingRemainder(dividingBy: 60))
        lapSecond = Int(lapTimeCount.truncatingRemainder(dividingBy: 60))
        lapMilliSecond = Int((lapTimeCount*100).truncatingRemainder(dividingBy: 100))
    }
    
    func stopCounting(){
        timer?.cancel()
    }
    
    func setTimer(){
        timer = Timer
            .publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.startCounting()
            }
    }
    
    func resetStopWatch(){
        timeCount = 0
        minute = 0
        second = 0
        milliSecond = 0
        resetCurrentLapTime()
    }
    
    func getFormatedTime(minute: Int, second: Int, milliSecond: Int) -> String{
        String(format: "%02d:%02d:%02d", minute, second, milliSecond)
    }
}

extension StopWatchObservable {
    func addLapTime(){
        let newLapTime = LapTime(lapCount: lapTimeList.count + 1, minute: lapMinute, second: lapSecond, milliSecond: lapMilliSecond)
        lapTimeList.append(newLapTime)
        resetCurrentLapTime()
        ratingLapTime()
    }
    
    func resetCurrentLapTime(){
        lapTimeCount = 0
        lapMinute = 0
        lapSecond = 0
        lapMilliSecond = 0
    }
    
    func resetLapTimeList(){
        lapTimeList.removeAll()
    }
    
    func ratingLapTime(){
        if lapTimeList.count > 1 {
            for lapTime in lapTimeList {
                caculateLapTime(lapTime)
            }
        }
    }
    
    private func caculateLapTime(_ laptime: LapTime){
        if laptime.minute >= maxLapTime.minute  && laptime.second >= maxLapTime.second &&  laptime.milliSecond >= maxLapTime.milliSecond {
            maxLapTime = laptime
        } else if laptime.minute <= minLapTime.minute && laptime.second <= minLapTime.second && laptime.milliSecond <= minLapTime.milliSecond {
            minLapTime = laptime
        }
    }
}
