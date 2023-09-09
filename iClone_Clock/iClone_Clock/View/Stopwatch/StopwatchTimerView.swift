//
//  StopwatchTimerView.swift
//  iClone_Clock
//
//  Created by Hyunjun Kim on 2023/08/30.
//

import SwiftUI

struct StopwatchTimerView: View {
    
    @ObservedObject var observable: StopwatchObserable
    
    var body: some View {
        TabView {
            DigitalTimer
            Text("Timer Image")
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .frame(height: UIScreen.main.bounds.height * 0.55)
    }
    
    @ViewBuilder
    var DigitalTimer: some View {
        Text("\(observable.counter + observable.laps.reduce(0, +))")
            .font(.largeTitle)
            .monospacedDigit()
    }
}

struct StopwatchTimerView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchTimerView(observable: StopwatchObserable())
    }
}
