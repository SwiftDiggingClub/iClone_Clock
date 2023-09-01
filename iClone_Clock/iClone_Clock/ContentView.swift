//
//  ContentView.swift
//  iClone_Clock
//
//  Created by hyunjun on 2023/08/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea(.all)
            TabView{
                WorldClockView()
                    .tabItem {
                        Image(systemName: "globe")
                        Text("세계시계")
                    }
                AlarmView()
                    .tabItem {
                        Image(systemName: "alarm")
                        Text("알람")
                    }
                StopWatchView()
                    .tabItem {
                        Image(systemName: "stopwatch")
                        Text("스톱워치")
                    }
                TimerView()
                    .tabItem {
                        Image(systemName: "timer")
                        Text("타이머")
                    }
            }
            .tint(.orange)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: - 다크모드
struct brightMode {
    static func myBackgroundColor(forScheme scheme: ColorScheme) -> Color {
        let lightColor = Color.white
        let darkColor = Color.black
        
        switch scheme{
        case .light : return lightColor
        case .dark : return darkColor
        @unknown default: return darkColor
        }
    }
}
