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
                            Text(city.meridiem ?? "")
                            Text(city.timeMinute ?? "")
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
                ForEach(worldTimerObservable.allCityList) { time in
                    Button {
//                        worldTimerObservable.worldCityTimeList.append(time)
                        isAddMode = false
                    } label: {
                        Text(time.city)
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
