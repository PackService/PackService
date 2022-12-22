//
//  AddTrackingNumberView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/22.
//

import SwiftUI

struct AddTrackingNumberView: View {
    
    @StateObject var companyVM = CompanyService()
    
    @State var trackingNumber = ""
    @State var selectedCompany = Company(id: "", international: "", name: "")
    
    var body: some View {
        VStack(spacing: 20) {
            Form {
                Picker(selection: $selectedCompany, label: Text("택배사 선택")) {
                    ForEach(companyVM.allCompanies.company) { company in
                        Text(company.name).tag(company)
                    }
                }
                .pickerStyle(.navigationLink)
                
                TextField("운송장 번호 입력", text: $trackingNumber)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
            }
            .frame(maxHeight: 200)
            
            VStack(alignment: .leading, spacing: 20) {                
                Text("선택한 택배사 코드: \(selectedCompany.id)")
                Text("운송장 번호: \(trackingNumber)")
            }
            
            
            Button {
                
            } label: {
                Text("운송장 조회")
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        
        Spacer()
        
        
    } 
}

struct AddTrackingNumberView_Previews: PreviewProvider {
    static var previews: some View {
        AddTrackingNumberView()
    }
}
