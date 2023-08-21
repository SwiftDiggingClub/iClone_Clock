//
//  AlermView.swift
//  iClone_Clock
//
//  Created by Seungui Moon on 2023/08/21.
//

import SwiftUI

struct AlermView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            Text("world time")
        }
        .foregroundColor(.green)
    }
}

struct AlermView_Previews: PreviewProvider {
    static var previews: some View {
        AlermView()
    }
}
