//
//  WorldClockListView.swift
//  iClone_Clock
//
//  Created by hyunjun on 2023/08/16.
//

import SwiftUI

struct WorldClockListView: View {
    
    let timezone: TimezoneData
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    @State var date = Date()
    @Binding var isTimeAppear: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Text(getDayDifference(identifier: timezone.identifier) + ", ")
                    Text(formatTimeDifference(getTimeDifference(identifier: timezone.identifier)))
                }
                    .foregroundColor(.gray)
                Text(timezone.locationInfo.cityInKorean)
                    .font(.title)
                    .fontWeight(.semibold)
            }
            Spacer()
            if isTimeAppear {
                Text(getTargetTime(identifier: timezone.identifier))
                    .monospacedDigit()
                    .font(.system(size: 40))
            }
        }
        .fontDesign(.rounded)
        .overlay {
            updateView
        }
        .onReceive(timer) { value in
            date = value
        }
    }
    
    @ViewBuilder private var updateView: some View {
        Text(date.description)
            .foregroundColor(.clear)
    }
    
    private func getTargetTime(identifier: String) -> String {
        let targetTimezone = TimeZone(identifier: identifier)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = targetTimezone
        dateFormatter.dateFormat = "HH:mm"
        
        let currentDate = Date()
        return dateFormatter.string(from: currentDate)
    }
    
    private func getTimeDifference(identifier: String) -> TimeInterval {
        guard let targetTimezone = TimeZone(identifier: identifier) else { return 0 }
        
        let currentDate = Date()
        let secondsDifference = TimeInterval(targetTimezone.secondsFromGMT(for: currentDate))
        let hoursDifference = secondsDifference / 3600.0
        let roundedHoursDifference = (hoursDifference * 10).rounded() / 10  // 반올림해서 소숫점 한 자리까지
        let hoursDifferenceFromKorea = roundedHoursDifference - 9
        return hoursDifferenceFromKorea
    }
    
    private func formatTimeDifference(_ hours: Double) -> String {
        let isPositive = hours > 0
        let integerHours = Int(abs(hours))
        let minutes = Int((abs(hours) - Double(integerHours)) * 60)
        
        var formattedTime = ""
        
        formattedTime += isPositive ? "+" : "-"
        
        if integerHours > 0 {
            formattedTime += "\(integerHours)시간"
        }
        
        if minutes > 0 {
            formattedTime += " \(minutes)분"
        }
        
        return formattedTime.isEmpty ? "0시간" : formattedTime
    }

    
    private func getDayDifference(identifier: String) -> String {
        let targetTimezone = TimeZone(identifier: "Asia/Seoul")
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = targetTimezone
        dateFormatter.dateFormat = "HH"
        
        guard let currentHour = Double(dateFormatter.string(from: Date())) else { return "error" }
        let hourDifference = getTimeDifference(identifier: identifier)
        
        if currentHour + hourDifference < 0 {
            return "어제"
        } else if currentHour + hourDifference > 24 {
            return "내일"
        } else {
            return "오늘"
        }
    }

}
