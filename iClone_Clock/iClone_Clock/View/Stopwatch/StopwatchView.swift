//
//  StopwatchView.swift
//  iClone_Clock
//
//  Created by hyunjun on 2023/08/16.
//

import SwiftUI

struct StopwatchView: View {
    
    @State var isStart = false
    
    var body: some View {
        VStack(spacing: 0) {
            StopwatchTimerView()
            .overlay(alignment: .bottom) {
                HStack {
                    CircleButton(label: "랩") {
                        
                    }
                    .foregroundColor(.primary)
                    .disabled(!isStart)
                    Spacer()
                    CircleButton(label: isStart ? "중단" : "시작") {
                        withAnimation() {
                            isStart.toggle()
                        }
                    }
                    .foregroundColor(isStart ? .red : .accentColor)
                }
                .padding()
            }
            
            Divider()
                .padding(.horizontal)
            
            LapListView()
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
