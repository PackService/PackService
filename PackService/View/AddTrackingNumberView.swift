//
//  AddTrackingNumberView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/22.
//

import SwiftUI

struct AddTrackingNumberView: View {
    
    @State var trackingNumber: String = ""
    @State var isValid: Bool = false
    @State var isSubmitted: Bool = false
    @FocusState var focusState: TextFieldType?
    @State var animationTrigger: Bool = false
    
    @State var text: String = ""
    

    
    var body: some View {
        ZStack {
            ColorManager.background
                .onTapGesture {
                    focusState = nil
                }
            
            VStack(spacing: 16) {
                TextFieldView(title: "운송장 번호를 입력하세요", input: $trackingNumber, wrongAttempt: $isValid, isFocused: $focusState, animationTrigger: $animationTrigger, type: .trackingNumber)
                    .keyboardType(.numberPad)
                    .onSubmit {
                        toggleFocus()
                    }
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            Button("Done") {
                                focusState = nil
                            }
                        }
                    }
                
                Button {
                    buttonPressed()
                } label: {
                    
                    HStack {
                        Text("택배사 선택")
                            .font(FontManager.body1)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17.6, height: 10.1)
                    }
                    .foregroundColor(ColorManager.foreground2)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 18)
                    .background(
                        ColorManager.background2
                            .cornerRadius(10)
                            
                    )
                }
                
                Spacer()                
                
                Button {
                    buttonPressed()
                } label: {
                    ButtonView(text: "운송장 등록")
                }

                
                
            }
            .padding(.horizontal, 20)
            .padding(.top, 41)
        }
        
        
    }
    
    func toggleFocus() {
        if focusState == .trackingNumber {
            focusState = nil
        }
    }
    
    func buttonPressed() {
        focusState = nil
    }
}

struct AddTrackingNumberView_Previews: PreviewProvider {
    static var previews: some View {
        AddTrackingNumberView()
    }
}

//let columns: [GridItem] = [
//    GridItem(.flexible(), spacing: nil, alignment: nil),
//    GridItem(.flexible(), spacing: nil, alignment: nil),
//    GridItem(.flexible(), spacing: nil, alignment: nil)
//]
//
//let numpads: [String] = [
//    "1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0", "back"
//]
//
//LazyVGrid(columns: columns) {
//    ForEach(numpads, id: \.self) { content in
//        Button {
//            buttonPressed(content)
//        } label: {
//            if content == "back" {
//                Image(systemName: "arrow.left")
//                    .renderingMode(.template)
//                    .resizable()
//                    .frame(width: 25, height: 20.7)
//                    .font(Font.custom("Pretendard-SemiBold", size: 32.0))
//                    .foregroundColor(ColorManager.defaultForeground)
//            } else {
//                Text(content)
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 52)
//                    .font(Font.custom("Pretendard-SemiBold", size: 32.0))
//                    .foregroundColor(ColorManager.defaultForeground)
//                    .padding(.vertical, 12)
////                                .background(Color.red)
//            }
//
//        }
//        .disabled(content.isEmpty)
//    }
//}
//.padding(.horizontal, -20)


//@StateObject var companyVM = CompanyService()
//
//@State var trackingNumber = ""
//@State var selectedCompany = Company(id: "", international: "", name: "")
//
//var body: some View {
//    VStack(spacing: 20) {
//        Form {
//            Picker(selection: $selectedCompany, label: Text("택배사 선택")) {
//                ForEach(companyVM.allCompanies.company) { company in
//                    Text(company.name).tag(company)
//                }
//            }
//            .pickerStyle(.navigationLink)
//
//            TextField("운송장 번호 입력", text: $trackingNumber)
//                .padding()
//                .background(Color(uiColor: .secondarySystemBackground))
//        }
//        .frame(maxHeight: 200)
//
//        VStack(alignment: .leading, spacing: 20) {
//            Text("선택한 택배사 코드: \(selectedCompany.id)")
//            Text("운송장 번호: \(trackingNumber)")
//        }
//
//        NavigationLink {
////                TrackingInfoView(companyId: selectedCompany.id, invoiceNumber: trackingNumber)
//            TrackingInfoLoadingView(companyId: $selectedCompany.id, invoiceNumber: $trackingNumber)
//        } label: {
//            Text("운송장 조회")
//                .foregroundColor(.white)
//                .padding(.vertical, 12)
//                .frame(width: UIScreen.main.bounds.width / 2)
//                .background(Color.blue)
//                .cornerRadius(10)
//        }
//
//        Spacer()
//    }
//
//    Spacer()
//
//}
