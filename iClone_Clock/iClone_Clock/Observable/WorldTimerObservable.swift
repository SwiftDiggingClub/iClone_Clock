//
//  WorldTimerObservable.swift
//  iClone_Clock
//
//  Created by Seungui Moon on 2023/08/21.
//

import SwiftUI

var dummyWorldTimeData = [
    WorldTime(city: "괌", timezoneOffset: +10 * 60 * 60),
    WorldTime(city: "뉴욕", timezoneOffset: -4 * 60 * 60),
    WorldTime(city: "런던", timezoneOffset: 0),
    WorldTime(city: "모스크바", timezoneOffset: +3 * 60 * 60)
]

class WorldTimerObservable: ObservableObject {
    @Published var timeZoneCityList: [WorldTime] = []
    @Published var allCityList: [WorldTime] = []
    
    var dateFormmater: DateFormatter
    
    init() {
        dateFormmater = DateFormatter()
        dateFormmater.locale = Locale(identifier: "ko_KR")
        dateFormmater.dateFormat = "a"
        
        for city in dummyWorldTimeData {
            let newCityData = WorldTime(city: city.city, timezoneOffset: city.timezoneOffset, meridiem: getMeridiem(city.timezoneOffset), timeMinute: getTimeMinute(city.timezoneOffset))
            timeZoneCityList.append(newCityData)
        }
        getTimeZoneCityList()
    }
    
    func addWorldTime(_ newWorldTime: WorldTime) {
        let renamedCityName = newWorldTime.city.split(separator: "/")
        var copiedCity = newWorldTime
        if let cityName = renamedCityName.last {
            copiedCity.city = String(cityName)
            timeZoneCityList.append(copiedCity)
        } else {
            timeZoneCityList.append(newWorldTime)
        }
    }
    
    func removeWorldTime(at offsets: IndexSet) {
        timeZoneCityList.remove(atOffsets: offsets)
    }
    
    func reorderWorldTime(_ from: IndexSet,_ to: Int) {
        timeZoneCityList.move(fromOffsets: from, toOffset: to)
    }
    
    private func getMeridiem(_ timeZoneOffset: Int) -> String {
        let timeZone = TimeZone(secondsFromGMT: timeZoneOffset)
        dateFormmater.timeZone = timeZone
        dateFormmater.locale = Locale(identifier: "ko_KR")
        
        dateFormmater.dateFormat = "a"
        return dateFormmater.string(from: Date())
    }
    
    private func getTimeMinute(_ timeZoneOffset: Int) -> String {
        let currentTime = Date()
        dateFormmater.dateFormat = "h:mm"
        
        return dateFormmater.string(from: currentTime)
    }
    
    private func getTimeZoneCityList(){
        let knownTimeZoneIdentifiers = TimeZone.knownTimeZoneIdentifiers
        for tz in knownTimeZoneIdentifiers {
            let timeZone = TimeZone(identifier: tz)
            if let _ = timeZone?.abbreviation(), let seconds = timeZone?.secondsFromGMT() {
                allCityList.append(WorldTime(city: "\(tz)", timezoneOffset: seconds, meridiem: getMeridiem(seconds), timeMinute: getTimeMinute(seconds)))
            }
        }
    }
}
