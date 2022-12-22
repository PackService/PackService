//
//  CompanyView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/21.
//

import SwiftUI

struct CompanyView: View {
    @StateObject var companyVM = CompanyService()
    
    var body: some View {
        
        List {
            Section(header: Text("국내 택배")) {
                ForEach(companyVM.allCompanies.company.filter { $0.international == "false"}) { company in
                    Button {
                        
                    } label: {
                        VStack(alignment: .leading) {
                            Text(company.name)
                                .bold()
                            Text(company.id)
                                .fontWeight(.light)
                        }
                    }
                }
            }
            
            Section(header: Text("국외 택배")) {
                ForEach(companyVM.allCompanies.company.filter { $0.international == "true"}) { company in
                    VStack(alignment: .leading) {
                        Text(company.name)
                            .bold()
                        Text(company.id)
                            .fontWeight(.light)
                    }
                }
            }
        }
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyView()
    }
}


////
////  HomeView.swift
////  PackService
////
////  Created by 이범준 on 11/29/22.
////
//
//import SwiftUI
//import Firebase
//
//struct HomeView: View {
//    @AppStorage("log_status") var log_Status = false
//    @StateObject var kakaoAuthVM = KakaoAuthVM()
//    @StateObject var companyVM = CompanyService()
//
//    @State var trackingNumber = ""
//    @State var selectedCompany = Company(id: "", international: "", name: "")
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Spacer()
//            NavigationView {
//
//                VStack(spacing: 20) {
//                    Form {
//                        Picker(selection: $selectedCompany, label: Text("택배사 선택")) {
//                            ForEach(companyVM.allCompanies.company) { company in
//                                Text(company.name).tag(company)
//                            }
//                        }
//                        .pickerStyle(.navigationLink)
//
//                        TextField("운송장 번호 입력", text: $trackingNumber)
//                            .padding()
//                            .background(Color(uiColor: .secondarySystemBackground))
//                    }
//                    .frame(maxHeight: 200)
//
//                    Button {
//
//                    } label: {
//                        Text("운송장 조회")
//                            .foregroundColor(.white)
//                            .padding(.vertical, 12)
//                            .frame(width: UIScreen.main.bounds.width / 2)
//                            .background(Color.blue)
//                            .cornerRadius(10)
//                    }
//                    Spacer()
//                }
//
//            }
//            Spacer()
//
//            HStack(spacing: 20) {
//                Text("\(selectedCompany.id)")
//                Text("\(trackingNumber)")
//            }
//
//
//            Text("Logged in successFully")
//            Button(action: {
//                //logout
//                DispatchQueue.global(qos: .background).async {
//                    try? Auth.auth().signOut()
//                    //카카오 로그인 했을 경우에만 아래 실행되도록 수정 필요
//                    try? kakaoAuthVM.kakaoLogout()
//                }
//                //back view to loginview
//                withAnimation(.easeInOut) {
//                    log_Status = false
//                }
//            }, label: {
//                Text("Log out")
//                    .fontWeight(.semibold)
//                    .foregroundColor(.white)
//                    .padding(.vertical, 12)
//                    .frame(width: UIScreen.main.bounds.width / 2)
//                    .background(Color.pink)
//                    .clipShape(Capsule())
//            })
//        }
//    }
//}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
