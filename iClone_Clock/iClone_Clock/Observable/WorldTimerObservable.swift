//
//  WorldTimerObservable.swift
//  iClone_Clock
//
//  Created by Seungui Moon on 2023/08/21.
//

import SwiftUI

let dummyWorldTimeData = [
    WorldTime(city: "괌", timezoneOffset: +10 * 60 * 60)
//    WorldTime(city: "뉴욕", timezoneOffset: -4 * 60 * 60),
//    WorldTime(city: "런던", timezoneOffset: 0),
//    WorldTime(city: "모스크바", timezoneOffset: +3 * 60 * 60),
//    WorldTime(city: "벤쿠버", timezoneOffset: -7 * 60 * 60),
//    WorldTime(city: "베이징", timezoneOffset: +8 * 60 * 60),
//    WorldTime(city: "서울", timezoneOffset: +9 * 60 * 60),
//    WorldTime(city: "암스테르담", timezoneOffset: +2 * 60 * 60),
//    WorldTime(city: "파리", timezoneOffset: +1 * 60 * 60),
//    WorldTime(city: "하노이", timezoneOffset: +7 * 60 * 60),
]

class WorldTimerObservable: ObservableObject {
    @Published var worldCityTimeList = dummyWorldTimeData
    @Published var TimeZoneCityList: [WorldTime] = []
    
    func removeItem(at offsets: IndexSet) {
        worldCityTimeList.remove(atOffsets: offsets)
       }
    func getFormattedTime(_ worldTime: WorldTime) -> Text {
        let currentTime = Date()
        let timeZone = TimeZone(secondsFromGMT: worldTime.timezoneOffset)
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale(identifier: "ko_KR")
        
        formatter.dateFormat = "a"
        let meridiem = formatter.string(from: currentTime)
        
        formatter.dateFormat = "h:mm"
        let timeMinute = formatter.string(from: currentTime)
        
        return Text("\(meridiem)").font(.largeTitle)
        + Text("\(timeMinute)")
            .font(.system(size: 55))
    }
    func getFormattedTimeWithOffset(_ offset: Int) -> Text {
        let currentTime = Date()
        let timeZone = TimeZone(secondsFromGMT: offset)
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale(identifier: "ko_KR")
        
        formatter.dateFormat = "a"
        let meridiem = formatter.string(from: currentTime)
        
        formatter.dateFormat = "h:mm"
        let timeMinute = formatter.string(from: currentTime)
        
        return Text("\(meridiem)").font(.largeTitle)
        + Text("\(timeMinute)")
            .font(.system(size: 55))
    }
    func getTimeZoneCityList(){
        let knownTimeZoneIdentifiers = TimeZone.knownTimeZoneIdentifiers
            for tz in TimeZone.knownTimeZoneIdentifiers {
                let timeZone = TimeZone(identifier: tz)
                if let abbreviation = timeZone?.abbreviation(), let seconds = timeZone?.secondsFromGMT() {
                    print ("timeZone: \(tz) \nabbreviation: \(abbreviation)\nsecondsFromGMT: \(seconds)\n")
                    TimeZoneCityList.append(WorldTime(city: "\(tz)", timezoneOffset: seconds))
                }
            }
    }
}
