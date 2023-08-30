//
//  StopwatchTimerView.swift
//  iClone_Clock
//
//  Created by Hyunjun Kim on 2023/08/30.
//

import SwiftUI

struct StopwatchTimerView: View {
    var body: some View {
        TabView {
            Text("Timer View")
            Text("Timer Image")
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .frame(height: UIScreen.main.bounds.height * 0.55)
    }
}

struct StopwatchTimerView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchTimerView()
    }
}
