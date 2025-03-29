//
//  ProfileView.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/29/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            Text("프로필 화면")
                .font(.title)
                .navigationTitle("프로필")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
