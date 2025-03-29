//
//  MoreView.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/29/25.
//

import SwiftUI

struct MoreView: View {
    var body: some View {
        NavigationStack {
            Text("더보기 화면")
                .font(.title)
                .navigationTitle("더보기")
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
