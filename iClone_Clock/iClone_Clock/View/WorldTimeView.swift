//
//  WorldTimeView.swift
//  iClone_Clock
//
//  Created by Seungui Moon on 2023/08/21.
//

import SwiftUI

struct WorldTimeView: View {
    @ObservedObject private var worldTimerObservable = WorldTimerObservable()
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Text("World Time")
                    .font(.system(size: 60, weight: .black))
                List {
                    ForEach(worldTimerObservable.worldCityTimeList, id: \.self) { cityTime in
                        HStack {
                            Text(cityTime.city)
                                .font(.system(size: 30, weight: .black))
                            Spacer()
                            worldTimerObservable.getFormattedTime(cityTime)
                        }
                        .listRowBackground(Color.black)
                        .padding(.vertical, 10)
                    }
                    .onDelete(perform: worldTimerObservable.removeItem)
                }
                .listStyle(.grouped)
                .background(.black)
                .scrollContentBackground(.hidden)
            }
            
        }
        .foregroundColor(.green)
    }
    
}

struct WorldTimeView_Previews: PreviewProvider {
    static var previews: some View {
        WorldTimeView()
    }
}
