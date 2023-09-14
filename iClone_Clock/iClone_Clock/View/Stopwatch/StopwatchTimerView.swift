//
//  StopwatchTimerView.swift
//  iClone_Clock
//
//  Created by Hyunjun Kim on 2023/08/30.
//

import SwiftUI

struct StopwatchTimerView: View {
    
    @StateObject var observable: StopwatchObserable
    
    var body: some View {
        TabView {
            DigitalTimer
            ImageTimer
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .frame(height: UIScreen.main.bounds.height * 0.55)
    }
    
    @ViewBuilder
    var DigitalTimer: some View {
        let timer = observable.counter + observable.laps.reduce(0, +)
        
        Text(observable.formattedTime(timer))
            .monospacedDigit()
            .font(.system(size: 100))
            .fontWeight(.thin)
            .minimumScaleFactor(0.5)
            .lineLimit(1)
            .padding(.horizontal)
    }
    
    @ViewBuilder
    var ImageTimer: some View {
        
        let totalSeconds = Double((observable.counter + observable.laps.reduce(0, +)) / 100 % 60)
        let seconds = Double(observable.counter / 100 % 60)
        
        ZStack {
            Circle()
                .foregroundColor(Color(.systemGray6))
                .overlay {
                    if observable.counter == 0 {
                        Rectangle()
                            .frame(width: 3)
                            .rotationEffect(.degrees(totalSeconds * 6), anchor: .center)
                            .foregroundColor(.orange)
                            .animation(.linear(duration: 0.1), value: totalSeconds)
                    }
                }
                .overlay {
                    if 1...(60 * 100) ~= observable.counter {
                        Rectangle()
                            .frame(width: 3)
                            .rotationEffect(.degrees(seconds * 6), anchor: .center)
                            .foregroundColor(.blue)
                            .animation(.linear(duration: 1), value: seconds)
                    }
                }
                .overlay {
                    if 1...(60 * 100) ~= observable.counter {
                        Rectangle()
                            .frame(width: 3)
                            .rotationEffect(.degrees(totalSeconds * 6), anchor: .center)
                            .foregroundColor(.orange)
                            .animation(.linear(duration: 1), value: totalSeconds)
                    }
                }
            Circle()
                .frame(width: 12)
                .foregroundColor(.orange)
            Circle()
                .frame(width: 6)
                .foregroundColor(Color(UIColor.systemBackground))
        }
        .padding()
    }
}

struct StopwatchTimerView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchTimerView(observable: StopwatchObserable())
    }
}
