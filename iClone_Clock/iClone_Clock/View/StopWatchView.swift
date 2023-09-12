//
//  StopWatchView.swift
//  iClone_Clock
//
//  Created by Seungui Moon on 2023/08/21.
//

import SwiftUI


struct StopWatchView: View {
    @ObservedObject private var stopWatchObservable = StopWatchObservable()
    @State private var isCounting = true
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                Text(stopWatchObservable.formatedMainTime)
                .monospacedDigit()
                .font(.system(size: 80, weight: .light))
                Spacer()
            }
            .frame(height: 300)
            
            HStack {
                if isCounting {
                    Button {
                        stopWatchObservable.addLapTime()
                        stopWatchObservable.ratingLapTime()
                    } label: {
                        StopWatchControlButton(buttonTest: "랩", bgColor: .white.opacity(0.2))
                    }
                    Spacer()
                    Button {
                        stopWatchObservable.stopCounting()
                        isCounting = false
                    } label: {
                        StopWatchControlButton(buttonTest: "중단", bgColor: .red.opacity(0.4), textColor: .red)
                    }
                } else {
                    Button {
                        stopWatchObservable.resetStopWatch()
                        stopWatchObservable.resetLapTimeList()
                    } label: {
                        StopWatchControlButton(buttonTest: "재설정", bgColor: .white.opacity(0.2))
                    }
                    Spacer()
                    Button {
                        stopWatchObservable.setTimer()
                        isCounting = true
                    } label: {
                        StopWatchControlButton(buttonTest: "시작", bgColor: .green.opacity(0.3), textColor: .green)
                    }
                }
            }
            .padding()
            ScrollView {
                
                VStack(spacing: 15) {
                    HStack {
                        Text("랩\(stopWatchObservable.lapTimeList.count + 1)")
                        Spacer()
                        Text(stopWatchObservable.formatedLapTime)
                            .monospacedDigit()
                    }
                
                    Divider()
                        .background(.white.opacity(0.3))
                }
                ForEach(stopWatchObservable.lapTimeList.reversed(), id: \.self) { lapTime in
                    VStack(spacing: 15) {
                        HStack {
                            Text("랩\(lapTime.lapCount)")
                            Spacer()
//                            Text("\(lapTime.minute)")
//                            Text("\(lapTime.second < 10 ? "0" : "")\(lapTime.second)")
//                            Text("\(lapTime.milliSecond < 10 ? "0" : "")\(lapTime.milliSecond)")
                            Text("\(lapTime.minute):\(lapTime.second):\(lapTime.milliSecond)")
                        }
                        .monospacedDigit()
                        Divider()
                            .background(.white.opacity(0.3))
                    }
                    .foregroundColor(
                        stopWatchObservable.maxLapTime.lapCount == lapTime.lapCount ? .red :
                            stopWatchObservable.minLapTime.lapCount == lapTime.lapCount ? .green : .white
                    )
                }
            }
            Spacer()
        }
        .foregroundColor(.white)
        .background(.black)
        .onReceive(stopWatchObservable.timer) { result in
            stopWatchObservable.startCounting()
        }
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView()
    }
}
