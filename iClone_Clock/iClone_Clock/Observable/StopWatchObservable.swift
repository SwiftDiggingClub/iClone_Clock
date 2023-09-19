//
//  StopWatchObservable.swift
//  iClone_Clock
//
//  Created by Seungui Moon on 2023/09/04.
//

import Combine
import Foundation

class StopWatchObservable: ObservableObject {
    
    @Published private var timeCount: Double = 0.0
    @Published private var timeModel = TimeModel(minute: 0, second: 0, milliSecond: 0)
    
    @Published private var lapTimeCount: Double = 0.0
    @Published private var lapTimeModel = TimeModel(minute: 0, second: 0, milliSecond: 0)
    
    @Published var lapTimeList: [LapTime] = []
    @Published var minLapTime = LapTime(lapCount: -1, minute: 99, second: 99, milliSecond: 99)
    @Published var maxLapTime = LapTime(lapCount: -1, minute: 0, second: 0, milliSecond: 0)
    
    private var timer: AnyCancellable?
    
    var formatedLapTime: String {
        String(format: "%02d:%02d:%02d", lapTimeModel.minute, lapTimeModel.second, lapTimeModel.milliSecond)
    }
    var formatedMainTime: String {
        String(format: "%02d:%02d:%02d", timeModel.minute, timeModel.second, timeModel.milliSecond)
    }
 
    func startCounting(){
        timeCount += 0.01
        timeModel = TimeModel(
            minute: Int((timeCount/60).truncatingRemainder(dividingBy: 60)),
            second: Int(timeCount.truncatingRemainder(dividingBy: 60)),
            milliSecond: Int((timeCount*100).truncatingRemainder(dividingBy: 100)))
        
        lapTimeCount += 0.01
        lapTimeModel = TimeModel(
            minute: Int((lapTimeCount/60).truncatingRemainder(dividingBy: 60)),
            second: Int(lapTimeCount.truncatingRemainder(dividingBy: 60)),
            milliSecond: Int((lapTimeCount*100).truncatingRemainder(dividingBy: 100)))
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
        timeModel = TimeModel(minute: 0, second: 0, milliSecond: 0)
        resetCurrentLapTime()
    }
    
    func getFormatedTime(minute: Int, second: Int, milliSecond: Int) -> String{
        String(format: "%02d:%02d:%02d", minute, second, milliSecond)
    }
}

extension StopWatchObservable {
    func addLapTime(){
        let newLapTime = LapTime(lapCount: lapTimeList.count + 1, minute: lapTimeModel.minute, second: lapTimeModel.second, milliSecond: lapTimeModel.milliSecond)
        lapTimeList.append(newLapTime)
        ratingLapTime()
        resetCurrentLapTime()
    }
    
    func resetCurrentLapTime(){
        lapTimeCount = 0
        lapTimeModel = TimeModel(minute: 0, second: 0, milliSecond: 0)
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
        if (laptime.minute, laptime.second, laptime.milliSecond) > (maxLapTime.minute, maxLapTime.second, maxLapTime.milliSecond) {
            maxLapTime = laptime
        }
        else if (laptime.minute, laptime.second, laptime.milliSecond) < (minLapTime.minute, minLapTime.second, minLapTime.milliSecond) {
            minLapTime = laptime
        }
    }
}
