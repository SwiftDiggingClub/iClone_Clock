//
//  StopWatchControlButton.swift
//  iClone_Clock
//
//  Created by Seungui Moon on 2023/09/05.
//

import SwiftUI

struct StopWatchControlButton: View {

    var buttonTest: String
    var bgColor: Color
    var textColor: Color = .white
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 4)
                .foregroundColor(bgColor)
                .frame(width: 100, height: 100)
            Circle()
                .fill(bgColor)
                .frame(width: 90, height: 90)
            Text(buttonTest)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(textColor)
        }
    }
}
