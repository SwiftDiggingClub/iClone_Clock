//
//  WorldTimeView.swift
//  iClone_Clock
//
//  Created by Seungui Moon on 2023/08/21.
//

import SwiftUI

struct WorldTimeView: View {
    @ObservedObject private var worldTimerObservable = WorldTimerObservable()
    @State private var isAddMode = false
    @State private var editMode = EditMode.inactive

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(worldTimerObservable.timeZoneCityList, id: \.id) { city in
                        HStack {
                            Text(city.city)
                                .font(.system(size: 30, weight: .black))
                            Spacer()
                            
                            if editMode != .active {
                                Text(city.meridiem ?? "")
                                    .font(.system(size: 20, weight: .medium))
                                    .padding(.top, 15)
                                Text(city.timeMinute ?? "")
                                    .font(.system(size: 40, weight: .bold))
                            }
                        }
                        .padding(.vertical, 10)
                    }
                    .onDelete(perform: worldTimerObservable.removeWorldTime)
                    .onMove { from, to in
                        worldTimerObservable.reorderWorldTime(from, to)
                    }
                }
                .listStyle(.grouped)
            }
            .navigationBarItems(leading: EditButton(), trailing: TrailingButton)
        }
        .scrollContentBackground(.hidden)
        .environment(\.editMode, $editMode)
        .sheet(isPresented: $isAddMode) {
            List {
                ForEach(worldTimerObservable.allCityList) { city in
                    Button {
                        worldTimerObservable.addWorldTime(city)
                        isAddMode = false
                    } label: {
                        Text(city.city)
                    }
                }
            }
            .listStyle(.plain)
            
        }
    }
    
    
    private var TrailingButton: some View {
        Button {
            isAddMode = true
        } label: {
            Image(systemName: "plus")
        }
    }
}

struct WorldTimeView_Previews: PreviewProvider {
    static var previews: some View {
        WorldTimeView()
    }
}
