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
                    ForEach(worldTimerObservable.worldCityTimeList, id: \.self) { cityTime in
                        HStack {
                            Text(cityTime.city)
                                .font(.system(size: 30, weight: .black))
                            Spacer()
                            worldTimerObservable.getFormattedTime(cityTime)
                        }
                        .padding(.vertical, 10)
                    }
                    .onDelete(perform: worldTimerObservable.removeItem)
                }
                .listStyle(.grouped)
            }
            .navigationBarItems(leading: EditButton(), trailing: TrailingButton)
        }
        .tint(.green)
        .foregroundColor(.green)
        .scrollContentBackground(.hidden)
        .environment(\.editMode, $editMode)
        .sheet(isPresented: $isAddMode) {
            List {
                ForEach(worldTimerObservable.TimeZoneCityList) { time in
                    Button {
                        worldTimerObservable.worldCityTimeList.append(time)
                        isAddMode = false
                    } label: {
                        Text(time.city)
                    }
                }
            }
            .listStyle(.plain)
        }
        .onAppear {
            worldTimerObservable.getTimeZoneCityList()
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
