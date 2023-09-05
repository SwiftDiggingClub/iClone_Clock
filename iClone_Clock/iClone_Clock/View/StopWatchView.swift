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
                HStack {
                    Text("\(stopWatchObservable.minute < 10 ? "0" : "")\(stopWatchObservable.minute)")
                        .frame(width: 100)
                    Text(":")
                    Text("\(stopWatchObservable.second < 10 ? "0" : "")\(stopWatchObservable.second)")
                        .frame(width: 100)
                    Text(":")
                    Text("\(stopWatchObservable.milliSecond < 10 ? "0" : "")\(stopWatchObservable.milliSecond)")
                        .frame(width: 100)
                }
                .font(.system(size: 80, weight: .light))
                Spacer()
            }
            .frame(height: 400)
            HStack {
                if isCounting {
                    Button {
                        stopWatchObservable.addLapTime()
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
                ForEach(stopWatchObservable.lapTimeList, id: \.self) { lapTime in
                    HStack {
                        Text("랩\(lapTime.lapCount)")
                        Spacer()
                        Text("\(lapTime.minute):\(lapTime.second):\(lapTime.milliSecond)")
                    }
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
