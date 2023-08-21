//
//  WorldTimeView.swift
//  iClone_Clock
//
//  Created by Seungui Moon on 2023/08/21.
//

import SwiftUI

struct WorldTimeView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            Text("World Time")
                .font(.system(size: 60, weight: .black))
        }
        .foregroundColor(.green)
    }
}

struct WorldTimeView_Previews: PreviewProvider {
    static var previews: some View {
        WorldTimeView()
    }
}
