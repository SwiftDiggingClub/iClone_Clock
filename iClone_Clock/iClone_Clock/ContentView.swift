//
//  ContentView.swift
//  iClone_Clock
//
//  Created by hyunjun on 2023/08/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WorldTimeView()
                .tabItem {
                    Label("세계 시계", systemImage: "globe")
                }
            AlermView()
                .tabItem {
                    Label("알람", systemImage: "alarm.fill")
                }
            StopWatchView()
                .tabItem {
                    Label("스톱워치", systemImage: "stopwatch.fill")
                }
            TimerView()
                .tabItem {
                    Label("타이머", systemImage: "timer")
                }
        }
        
        .tint(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
