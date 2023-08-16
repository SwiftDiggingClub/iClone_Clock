//
//  MainView.swift
//  iClone_Clock
//
//  Created by hyunjun on 2023/08/16.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            WorldClockView()
                .tabItem { Label("세계 시계", systemImage: "globe.asia.australia") }
            AlarmView()
                .tabItem { Label("알람", systemImage: "alarm") }
            StopwatchView()
                .tabItem { Label("스톱워치", systemImage: "stopwatch") }
            TimerView()
                .tabItem { Label("타이머", systemImage: "timer") }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
