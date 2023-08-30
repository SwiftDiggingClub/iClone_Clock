//
//  SearchBarView.swift
//  iClone_Clock
//
//  Created by hyunjun on 2023/08/16.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("검색", text: $searchText)
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color(.systemGray3))
                            .scaleEffect(1.2)
                    }
                }
            }
            .padding(8)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .foregroundStyle(Color(.systemGray5))
            }
            
            Button("취소", action: action)
        }
        .padding(.leading, 10)
        .padding(.trailing, 16)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant("")) {
            //action here
        }
    }
}
