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
    
    @State var text: String? = nil
    
    @State var showSelectCompanyView: Bool = false
    
    @State var width = CGFloat.zero
    @State var height = CGFloat.zero
    
    var body: some View {
        ZStack {
            ColorManager.background
                .onTapGesture {
                    focusState = nil
                }
            
            VStack(alignment: .leading, spacing: 16) {
                TextFieldView(title: "운송장 번호를 입력하세요", input: $trackingNumber, wrongAttempt: $isValid, isFocused: $focusState, animationTrigger: $animationTrigger, type: .trackingNumber)
                    .keyboardType(.numberPad)
                    .onSubmit {
                        toggleFocus()
                    }
                
                Button {
                    buttonPressed()
                    
                } label: {
                    
                    HStack {
                        Text(text ?? "택배사 선택")
                            .font(FontManager.body1)
                            .foregroundColor(text == nil ? ColorManager.foreground2 : ColorManager.defaultForeground)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17.6, height: 10.1)
                            .foregroundColor(ColorManager.foreground2)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 18)
                    .background(
                        ColorManager.background2
                            .cornerRadius(10)
                    )
                }

                GeometryReader { geo in
                    self.content(proxy: geo)
                }
                
                Spacer()
                
                Button {
                    buttonPressed()
                } label: {
                    ButtonView(text: "운송장 등록")
                }
                .padding(.bottom, 16)
                
            }
            .padding(.horizontal, 20)
            .padding(.top, 41)
            
            ZStack {
                if showSelectCompanyView {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            showSelectCompanyView = false
                        }
                    
                    SelectCompanyView(show: $showSelectCompanyView, selected: $text)
                        .padding(.top, 100)
                        .transition(.move(edge: .bottom))
                }
            }
            .animation(.spring(), value: showSelectCompanyView)
            .zIndex(2.0)
        }
    }
    
    private func content(proxy: GeometryProxy) -> some View {
        
        let names = ["롯데택배", "CJ 대한통운", "CJ 대한통운1", "DHL Express Delivery", "CU PostBox", "GS"]
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            
            ForEach(names, id: \.self) { name in
                Button(action: {
                    capsulePressed(name)
                }, label: {
                    CompanyCapsuleView(color: Color.red, logoImage: Image("CJ_logo"), logoName: name, nameColor: Color.white)
                })
                  .padding([.horizontal, .vertical], 3)
                  .alignmentGuide(.leading, computeValue: { value in
                        if abs(width - value.width) > proxy.size.width {
                          width = 0
                          height -= value.height
                        }
                        let result = width
                      if name == names.last! {
                          width = 0
                        } else {
                          width -= value.width
                        }
                        return result
                  })
                  .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        if name == names.last! {
                          height = 0
                        }
                        return result
                  })
            }
        }
    }
    
    func toggleFocus() {
        if focusState == .trackingNumber {
            focusState = nil
        }
    }
    
    func buttonPressed() {
        focusState = nil
        showSelectCompanyView = true
    }
    
    func capsulePressed(_ name: String) {
        self.text = name
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
