//
//  HomeView.swift
//  PackService
//
//  Created by 이범준 on 11/29/22.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @AppStorage("log_status") var logStatus = false
    @StateObject var kakaoAuthVM = KakaoAuthVM()
    @StateObject var emailAuthVM = EmailAuthVM()
    @State var currentUser: String = ""
    
    @State var testTrackNumber: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Logged in successFully")
                
                Button(action: {
                    // logout
                    DispatchQueue.global(qos: .background).async {
                        try? Auth.auth().signOut()
                        // 카카오 로그인 했을 경우에만 아래 실행되도록 수정 필요
                        try? kakaoAuthVM.kakaoLogout()
                    }
                    // back view to loginview
                    withAnimation(.easeInOut) {
                        logStatus = false
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
                
                TextField("배송번호", text: $testTrackNumber)
                Text(currentUser)
                Text(testTrackNumber)
                Button(action: {
                    emailAuthVM.addTrackNumber(trackNumber: testTrackNumber, trackCompany: testTrackNumber)
                }, label: {
                    Text("test버튼")
                })
                
                Spacer()
                
                NavigationLink {
                    AddTrackingNumberView()
                } label: {
                    Text("운송장 번호 등록")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .frame(width: UIScreen.main.bounds.width / 2)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                NavigationLink {
                    RecommendTrackView()
                } label: {
                    Text("추천 택배사 조회")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .frame(width: UIScreen.main.bounds.width / 2)
                        .background(Color.blue)
                        .cornerRadius(10)
                }

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
