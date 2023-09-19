//
//  WorldTime.swift
//  iClone_Clock
//
//  Created by Seungui Moon on 2023/08/22.
//

import Foundation

struct WorldTime: Hashable, Identifiable {
    let id = UUID().uuidString
    var city: String
    var timezoneOffset: Int
    var meridiem: String?
    var timeMinute: String?
}
