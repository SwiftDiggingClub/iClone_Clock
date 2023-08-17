//
//  AddClockView.swift
//  iClone_Clock
//
//  Created by hyunjun on 2023/08/16.
//

import SwiftUI

struct AddClockView: View {
    
    @ObservedObject var model: WorldClockModel
    @Binding var addClock: Bool
    
    private var filteredTimezoneDatas: [TimezoneData] {
        if model.searchText.isEmpty {
            return model.timezoneDatas
        } else {
            let lowercaseSearchText = model.searchText.lowercased()
            return model.timezoneDatas.filter { timezone in
                let cityInKorean = timezone.locationInfo.cityInKorean.lowercased()
                let countryInKorean = timezone.locationInfo.countryInKorean.lowercased()
                let cityInEnglish = timezone.locationInfo.cityInEnglish.lowercased()
                let countryInEnglish = timezone.locationInfo.countryInEnglish.lowercased()
                
                return cityInKorean.contains(lowercaseSearchText) ||
                countryInKorean.contains(lowercaseSearchText) || cityInEnglish.contains(lowercaseSearchText) || countryInEnglish.contains(lowercaseSearchText)
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredTimezoneDatas.sorted(by: { $0.locationInfo.cityInKorean < $1.locationInfo.cityInKorean })) { timezone in
                Button {
                    if model.selectedTimezoneDatas.firstIndex(where: { $0.id == timezone.id }) == nil {
                        model.selectedTimezoneDatas.append(timezone)
                    }
                    addClock = false
                } label: {
                    HStack(spacing: 0) {
                        Text(timezone.locationInfo.cityInKorean + ", ")
                        Text(timezone.locationInfo.countryInKorean)
                    }
                    .foregroundColor(.primary)
                }
            }
        }
        .listStyle(.inset)
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
        AddClockView(model: WorldClockModel(), addClock: .constant(false))
    }
}
