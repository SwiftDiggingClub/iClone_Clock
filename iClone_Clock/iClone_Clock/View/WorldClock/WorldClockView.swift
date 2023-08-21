//
//  WorldClockView.swift
//  iClone_Clock
//
//  Created by hyunjun on 2023/08/16.
//

import SwiftUI

struct WorldClockView: View {
    
    @StateObject private var model = WorldClockModel()
    
    @State var isEditing = false
    @State private var addClock = false
    @State private var isTimeAppear = true
    
    let time = TimeZone(identifier: "Asia/Seoul")
            
    var body: some View {
        NavigationStack {
            List {
                ForEach(model.selectedTimezoneDatas) { timezone in
                    WorldClockListView(timezone: timezone, isTimeAppear: $isTimeAppear)
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
                .listRowBackground(EmptyView())
            }
            .listStyle(.inset)
            .navigationTitle("세계 시계")
            .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    editButton
                }
                ToolbarItem {
                    addWorldClockButton
                }
            }
            .sheet(isPresented: $addClock) {
                AddClockView(model: model, addClock: $addClock)
            }
        }
    }
    
    @ViewBuilder
    private var addWorldClockButton: some View {
        Button {
            addClock = true
        } label: {
            Image(systemName: "plus")
                .fontWeight(.medium)
        }
    }
    
    @ViewBuilder
    private var editButton: some View {
        Button {
            withAnimation() {
                isTimeAppear.toggle()
                isEditing.toggle()
            }
        } label: {
            Text(isEditing ? "완료" : "편집")
            .fontWeight(.medium)
        }
    }
    
    private func delete(indexSet: IndexSet) {
        model.selectedTimezoneDatas.remove(atOffsets: indexSet)
        model.saveData()
    }
    
    private func move(indices: IndexSet, newOffset: Int) {
        model.selectedTimezoneDatas.move(fromOffsets: indices, toOffset: newOffset)
        model.saveData()
    }
}

struct WorldClockView_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockView()
    }
}
