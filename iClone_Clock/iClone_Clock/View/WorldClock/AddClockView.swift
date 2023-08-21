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
    
    private let hangulConsonant = ["ㄱ","ㄴ","ㄷ","ㄹ","ㅁ","ㅂ","ㅅ","ㅆ","ㅇ","ㅈ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ZStack {
                    List {
                        ForEach(model.groupedTimezones(timezones: filteredTimezones()).sorted(by: { $0.key < $1.key }), id: \.key) { header, timezones in
                            Section(header: Text(header).id(header)) {
                                ForEach(timezones, id: \.id) { timezone in
                                    Button {
                                        if !model.selectedTimezoneDatas.contains(where: { $0.id == timezone.id }) {
                                            model.selectedTimezoneDatas.append(timezone)
                                            model.saveData()
                                        }
                                        addClock = false
                                    } label: {
                                        HStack {
                                            Text("\(timezone.locationInfo.cityInKorean), \(timezone.locationInfo.countryInKorean)")
                                        }
                                        .foregroundColor(.primary)
                                    }
                                }
                            }
                        }
                    }
                    .overlay(alignment: .trailing) {
                        if model.searchText.isEmpty {
                            VStack {
                                ForEach(hangulConsonant, id: \.self) { header in
                                    Button(header) {
                                        withAnimation(.spring()) {
                                            proxy.scrollTo(header, anchor: .top)
                                        }
                                    }
                                    .padding(.trailing, 5)
                                    .font(.footnote)
                                }
                            }
                        }
                    }
                    
                    if filteredTimezones().isEmpty {
                        VStack {
                            Text("검색결과가 없습니다")
                        }
                    }
                }
            }
            .listStyle(.inset)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("도시 검색")
                        .font(.footnote)
                }
            }
            .searchable(text: $model.searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
    
    private func filteredTimezones() -> [TimezoneData] {
        let lowercaseSearchText = model.searchText.lowercased()
        
        return model.timezoneDatas.filter { timezone in
            let location = timezone.locationInfo
            
            return [location.cityInKorean, location.countryInKorean, location.cityInEnglish, location.countryInEnglish]
                .map { $0.lowercased() }
                .contains { $0.contains(lowercaseSearchText) } || model.searchText.isEmpty
        }
    }
}

struct AddClockView_Previews: PreviewProvider {
    static var previews: some View {
        AddClockView(model: WorldClockModel(), addClock: .constant(false))
    }
}
