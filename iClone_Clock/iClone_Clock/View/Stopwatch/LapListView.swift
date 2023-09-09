//
//  LapListView.swift
//  iClone_Clock
//
//  Created by Hyunjun Kim on 2023/08/30.
//

import SwiftUI

struct LapListView: View {
    
    @ObservedObject var observable: StopwatchObserable
    
    var body: some View {
        
        let lapsCount = observable.laps.count
        let laps = observable.laps
        
        let maxLap = laps.max() ?? 0
        let minLap = laps.min() ?? 0
        
        List {
            HStack {
                Text("랩 \(lapsCount + 1)")
                Spacer()
                Text("\(observable.counter)")
            }
            if !observable.laps.isEmpty {
                ForEach(laps.enumerated().reversed(), id: \.offset) { index, lap in
                    HStack {
                        Text("랩 \(index + 1)")
                        Spacer()
                        Text("\(lap)")
                            .foregroundColor(lap == maxLap ? .red : lap == minLap ? .green : .primary)
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
