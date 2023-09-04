//
//  StopWatchView.swift
//  iClone_Clock
//
//  Created by Seungui Moon on 2023/08/21.
//

import SwiftUI



struct StopWatchView: View {
    @ObservedObject private var stopWatchObservable = StopWatchObservable()
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                HStack {
                    Text("\(stopWatchObservable.minute)")
                        .frame(width: 100)
                    Text(":")
                    Text("\(stopWatchObservable.second)")
                        .frame(width: 100)
                    Text(":")
                    Text("\(stopWatchObservable.milliSecond)")
                        .frame(width: 100)
                }
                .font(.system(size: 80, weight: .light))
                Spacer()
            }
            .frame(height: 400)
            HStack {
                Button {
                    
                } label: {
                    Text("재설정")
                }
                Spacer()
                Button {
                    stopCounting()
                } label: {
                    Text("시작")
                }
            }
            .padding()
            ScrollView {
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
