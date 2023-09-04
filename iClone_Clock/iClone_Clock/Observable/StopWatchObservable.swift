//
//  StopWatchObservable.swift
//  iClone_Clock
//
//  Created by Seungui Moon on 2023/09/04.
//

import Foundation

class StopWatchObservable: ObservableObject {
    @Published var time = ""
    @Published var minute = 0
    @Published var second  = 0
    @Published var milliSecond = 0
    @Published var lapTimeList: [LabTime] = []
    
}
