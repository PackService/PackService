//
//  HomeView.swift
//  PackService
//
//  Created by 이범준 on 11/29/22.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @AppStorage("log_status") var log_Status = false
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Logged in successFully using apple login")
                Button(action: {
                    //logout
                    DispatchQueue.global(qos: .background).async {
                        try? Auth.auth().signOut()
                    }
                    //back view to loginview
                    withAnimation(.easeInOut) {
                        log_Status = false
                    }
                }, label: {
                    Text("Log out")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .frame(width: UIScreen.main.bounds.width / 2)
                        .background(Color.pink)
                        .clipShape(Capsule())
                })
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
