//
//  WorldClockListView.swift
//  iClone_Clock
//
//  Created by hyunjun on 2023/08/16.
//

import SwiftUI

struct WorldClockListView: View {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("오늘, +0시간")
                    .font(.caption)
                    .foregroundStyle(Color(.darkGray))
                Text("서울")
                    .font(.title)
                    .fontWeight(.semibold)
            }
            Spacer()
            Text("20:00")
                .monospacedDigit()
                .font(.system(size: 45))
        }
        .fontDesign(.rounded)
    }
}

struct WorldClockListView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            WorldClockListView()
        }
        .listStyle(.inset)
    }
}
