//
//  StopwatchView.swift
//  iClone_Clock
//
//  Created by hyunjun on 2023/08/16.
//

import SwiftUI

struct StopwatchView: View {
    
    @StateObject var observable = StopwatchObserable()
    @State var isStart = false
    
    var body: some View {
        VStack(spacing: 0) {
            StopwatchTimerView(observable: observable)
                .overlay(alignment: .bottom) {
                    HStack {
                        CircleButton(label: isStart ? "랩" : "재설정") {
                            if isStart {
                                observable.lapTimer()
                            } else {
                                observable.resetTimer()
                            }
                        }
                        .foregroundColor(.primary)
                        Spacer()
                        CircleButton(label: isStart ? "중단" : "시작") {
                            isStart.toggle()
                            if isStart {
                                observable.startTimer()
                            }
                            else {
                                observable.stopTimer()
                            }
                        }
                        .foregroundColor(isStart ? .red : .green)
                    }
                    .padding()
                }
            
            Divider()
                .padding(.horizontal)

            
            if isStart || !observable.laps.isEmpty {
                LapListView(observable: observable)
                    .scrollDisabled(false)
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func CircleButton(label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            ZStack {
                Text(label)
                Circle()
                    .frame(width: 70)
                    .foregroundStyle(.quaternary)
                Circle()
                    .stroke(lineWidth: 3)
                    .frame(width: 76)
                    .foregroundStyle(.quaternary)
            }
        }
        .buttonStyle(.plain)
    }
}

struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
    }
}
