//
//  WorldClockView.swift
//  iClone_Clock
//
//  Created by hyunjun on 2023/08/16.
//

import SwiftUI

struct WorldClockView: View {
    
    @State private var addClock = false
    
    var body: some View {
        NavigationStack {
            List {
                WorldClockListView()
            }
            .listStyle(.inset)
            .navigationTitle("세계 시계")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .fontWeight(.medium)
                }
                ToolbarItem {
                    Button {
                        addClock = true
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.medium)
                    }
                }
            }
            .sheet(isPresented: $addClock) {
                AddClockView(addClock: $addClock)
            }
        }
    }
}

struct WorldClockView_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockView()
    }
}
