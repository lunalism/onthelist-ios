//
//  CollectionView.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/29/25.
//

import SwiftUI

struct CollectionView: View {
    var body: some View {
        NavigationStack {
            Text("컬렉션 화면")
                .font(.title)
                .navigationTitle("컬렉션")
        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
