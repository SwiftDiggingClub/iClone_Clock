//
//  LabTime.swift
//  iClone_Clock
//
//  Created by Seungui Moon on 2023/09/04.
//

import Foundation

struct LapTime: Hashable {
    let lapCount: Int
    let minute: Int
    let second: Int
    let milliSecond: Int
}

struct TimeModel {
    let minute: Int
    let second: Int
    let milliSecond: Int
}
