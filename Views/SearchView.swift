//
//  SearchView.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/29/25.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationStack {
            Text("검색 화면")
                .font(.title)
                .navigationTitle("검색")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
