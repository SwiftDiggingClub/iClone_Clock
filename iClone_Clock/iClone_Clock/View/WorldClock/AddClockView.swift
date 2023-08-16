//
//  AddClockView.swift
//  iClone_Clock
//
//  Created by hyunjun on 2023/08/16.
//

import SwiftUI

struct AddClockView: View {
    
    @Binding var addClock: Bool
    
    var body: some View {
        Text("AddClock")
    }
}

struct AddClockView_Previews: PreviewProvider {
    static var previews: some View {
        AddClockView(addClock: .constant(false))
    }
}
