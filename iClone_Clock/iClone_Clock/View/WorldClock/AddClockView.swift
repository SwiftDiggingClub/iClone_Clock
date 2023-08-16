//
//  AddClockView.swift
//  iClone_Clock
//
//  Created by hyunjun on 2023/08/16.
//

import SwiftUI

struct AddClockView: View {
    
    @StateObject private var model = WorldClockModel()
    @Binding var addClock: Bool
    
    var body: some View {
        List {
            ForEach(TimeZone.knownTimeZoneIdentifiers, id: \.self) { timezone in
                Button {
                    addClock = false
                } label: {
                    Text(timezone)
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(.top, -8)
        .safeAreaInset(edge: .top) {
            VStack {
                Text("도시 선택")
                    .padding(.top, 16)
                    .font(.callout)
                SearchBarView(searchText: $model.searchText) {
                    addClock = false
                }
            }
            .padding(.bottom, 12)
            .background {
                VStack(spacing: 0) {
                    Rectangle()
                        .foregroundStyle(.ultraThinMaterial)
                        .ignoresSafeArea()
                    Divider()
                }
            }
        }
    }
}

struct AddClockView_Previews: PreviewProvider {
    static var previews: some View {
        AddClockView(addClock: .constant(false))
    }
}
