//
//  WorldClockModel.swift
//  iClone_Clock
//
//  Created by hyunjun on 2023/08/16.
//

import Foundation

struct LocationInfo {
    let cityInEnglish: String
    let cityInKorean: String
    let countryInEnglish: String
    let countryInKorean: String
}

struct TimezoneData: Identifiable {
    let id = UUID()
    let identifier: String
    let locationInfo: LocationInfo
}

class WorldClockModel: ObservableObject {
    
    @Published var timezoneDatas: [TimezoneData] = []
    @Published var selectedTimezoneDatas: [TimezoneData] = []
    @Published var searchText: String = ""
    
    init() {
        addTimezoneData()
    }
    
    private func getCity(identifier: String) -> String {
        guard let city = identifier.split(separator: "/").last else {
            return "error"
        }
        
        if city.contains("_") {
            let cityName = city.replacingOccurrences(of: "_", with: " ")
            return cityName
        } else {
            return String(city)
        }
    }
    
    private func getLocationInfo(identifier: String) -> LocationInfo {
        let cityInEnglish = getCity(identifier: identifier)
        return locationInfoDictionary[identifier] ?? LocationInfo(cityInEnglish: cityInEnglish, cityInKorean: "n/a", countryInEnglish: identifier, countryInKorean: "n/a")
    }
    
    
    private func addTimezoneData() {
        for identifier in TimeZone.knownTimeZoneIdentifiers {
            timezoneDatas.append(TimezoneData(identifier: identifier, locationInfo: getLocationInfo(identifier: identifier)))
        }
    }
}
