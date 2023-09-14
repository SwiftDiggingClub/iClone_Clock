//
//  LapListView.swift
//  iClone_Clock
//
//  Created by Hyunjun Kim on 2023/08/30.
//

import SwiftUI

struct LapListView: View {
    
    @StateObject var observable: StopwatchObserable
    
    var body: some View {
        List {
            HStack {
                Text("랩 \(observable.laps.count + 1)")
                Spacer()
                Text(observable.formattedTime(observable.counter))
                    .monospacedDigit()
            }
            if !observable.laps.isEmpty {
                ForEach(observable.laps.enumerated().reversed(), id: \.offset) { index, lap in
                    HStack {
                        Text("랩 \(index + 1)")
                        Spacer()
                        Text(observable.formattedTime(lap))
                            .foregroundColor(observable.lapColor(lap))
                            .monospacedDigit()
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

struct LapListView_Previews: PreviewProvider {
    static var previews: some View {
        LapListView(observable: StopwatchObserable())
    }
}
