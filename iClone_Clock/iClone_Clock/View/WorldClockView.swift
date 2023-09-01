//
//  WorldClockView.swift
//  iClone_Clock
//
//  Created by qwd on 2023/08/30.
//

import SwiftUI

struct WorldClockView: View {
    var body: some View {
        let city = ["korea","bangkok","seoul","tokyo"]
        NavigationStack{
            List(city, id:\.self){
                Text($0)
            }
            .listStyle(.inset)
            .navigationBarTitle("세계 시계")
        }

    }
}






struct WorldClockView_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockView()
    }
}
