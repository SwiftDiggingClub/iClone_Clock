//
//  StopWatchView.swift
//  iClone_Clock
//
//  Created by Seungui Moon on 2023/08/21.
//

import SwiftUI

struct LabTime: Hashable {
    let lapCount: Int
    let lapTime: String
}

struct StopWatchView: View {
    @ObservedObject private var stopWatchObservable = StopWatchObservable()
    var body: some View {
        VStack {
            VStack {
                Spacer()
                Text("0\(stopWatchObservable.minute):0\(stopWatchObservable.second):0\(stopWatchObservable.milliSecond)")
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
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView()
    }
}
