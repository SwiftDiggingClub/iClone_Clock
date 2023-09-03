////
////  WorldClockModel.swift
////  iClone_Clock
////
////  Created by qwd on 2023/09/02.
////
//
//import Foundation
//
////Non UI Things
//
////struct WorldClockModel<CardContent> {
////    var cards: Array<Card>
////
////    func choose(card: Card) {
////        //scoring
////    }
////
////    struct Cardc {
////        var isFaceUP: Bool
////        var isMatched: Bool
//////        var content: String : emoji도 있을 수 있으니까
////        var content: CardContent
////    }
////}
////
//
//struct WorldClockView: View {
//    @State private var selectedTimeZone = TimeZone.current
//    let timeZones: [TimeZone] = [TimeZone(identifier: "America/New_York")!, TimeZone(identifier: "Europe/London")!, TimeZone(identifier: "Asia/Tokyo")!]
//
//    var body: some View {
//        VStack {
//            Text("세계 시계")
//                .font(.largeTitle)
//                .padding()
//
//            Text(selectedTimeZone.identifier)
//                .font(.title)
//                .padding()
//
//            Text(currentTime(for: selectedTimeZone))
//                .font(.system(size: 60))
//                .padding()
//
//            Picker("시간대 선택", selection: $selectedTimeZone) {
//                ForEach(timeZones, id: \.self) { timeZone in
//                    Text(timeZone.identifier)
//                }
//            }
//            .pickerStyle(SegmentedPickerStyle())
//            .padding()
//
//            Spacer()
//        }
//    }
//
//    func currentTime(for timeZone: TimeZone) -> String {
//        let formatter = DateFormatter()
//        formatter.timeZone = timeZone
//        formatter.dateFormat = "HH:mm:ss"
//        return formatter.string(from: Date())
//    }
//}
//
//struct WorldClockView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorldClockView()
//    }
//}
//
