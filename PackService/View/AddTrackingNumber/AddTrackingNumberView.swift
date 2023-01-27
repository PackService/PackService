//
//  AddTrackingNumberView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/22.
//

import SwiftUI

struct AddTrackingNumberView: View {
    
    @Environment(\.dismiss) private var dismissAddTrackingNumberView
    @StateObject var recommendVM = RecommendService("")
    @State var selectedCompany = Recommend(id: "", international: "", name: "")
    @State var trackingNumber: String = ""
    @State var isValid: Bool = false
    @State var isSubmitted: Bool = false //
    @State var trackAttempt: Bool = false
    @FocusState var focusState: TextFieldType?
    @State var animationTrigger: Bool = false
    
    @State var text: String? = nil
    
    @State var showSelectCompanyView: Bool = false

    var body: some View {
        ZStack {
            background
            
            VStack(alignment: .leading, spacing: 16) {
                trackingNumberTextField
                
                selectCompanyButton

                companyCapsuleList
                
                Spacer()
                
                addTrackingNumberButton
            }
            .padding(.horizontal, 20)
            .padding(.top, 41)
            
            ZStack {
                if showSelectCompanyView {
                    selectCompanyViewBackground
                    
                    selectCompanyView
                }
            }
            .animation(.spring(), value: showSelectCompanyView)
            .zIndex(2.0)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("운송장 등록")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismissAddTrackingNumberView()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(ColorManager.defaultForeground)
                    }
                }
            }
        }
//        .onDisappear() 이거 12345 송장번호 통과되면 textfield변수들 다시 초기로 돌려줘야 함
    }
    
    private func content(proxy: GeometryProxy) -> some View {
        
        let sortedRecommend = recommendVM.allRecommend.recommend.sorted(by: {$0.id < $1.id}).prefix(6)
        
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            
            ForEach(sortedRecommend) { name in
                let company = LogoType(rawValue: name.id) ?? LogoType.etc
                
                // Custom Button Style 재정의 해야함
                Button(action: {
                    capsulePressed(name.name)
                }, label: {
                    CompanyCapsuleView(color: company.logo.bgColor, logoImage: company.logo.image, logoName: name.name, nameColor: company.logo.fgColor)
                })
                .buttonStyle(ContainerButtonStyle())
                  .padding([.horizontal, .vertical], 4)
                  .alignmentGuide(.leading, computeValue: { value in
                      if abs(width - value.width) > proxy.size.width {
                          width = 0
                          height -= value.height
                      }
                      let result = width
                      if name.id == sortedRecommend.last!.id {
                          width = 0
                      } else {
                          width -= value.width
                      }
                      return result
                  })
                  .alignmentGuide(.top, computeValue: { _ in
                      let result = height
                      if name.id == sortedRecommend.last!.id {
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

    // MARK: - buttonPressed()
    func buttonPressed() {
//        focusState = nil
        isSubmitted = true
        validationCheck()
        
        trackAttempt = !(isSubmitted && isValid)

        if trackAttempt {
            withAnimation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                animationTrigger = true
            }
        } else {
            emailAuthVM.addTrackNumber(trackNumber: trackingNumber, trackCompany: selectedCompany.name)
        }
        
        animationTrigger = false
    }

    
    
    func selectButtonPressed() {
        showSelectCompanyView = true
    }
    
    func capsulePressed(_ name: String) {
        self.text = name
    }
    
    func validationCheck() {
        if trackingNumber == "12345" {
            self.isValid = true
        }
    }
    
}

extension AddTrackingNumberView {
    var background: some View {
        ColorManager.background
            .onTapGesture {
                focusState = nil
            }
    }
    
    
    var trackingNumberTextField: some View {
        
        TextFieldView(title: "운송장 번호를 입력하세요", input: $trackingNumber, wrongAttempt: $trackAttempt, isFocused: $focusState, animationTrigger: $animationTrigger, type: .trackingNumber)
            .keyboardType(.numberPad)
            .onSubmit {
                toggleFocus()
            }
            .onChange(of: trackingNumber) { _ in
                recommendVM.getRecommendCompanies(trackingNumber)
            }
    }
    
    var selectCompanyButton: some View {
        Button {
            selectButtonPressed()
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
    }
    
    var companyCapsuleList: some View {
        GeometryReader { geo in
            self.content(proxy: geo)
        }
    }
    
    var addTrackingNumberButton: some View {
        Button {
            buttonPressed()
        } label: {
            ButtonView(text: "운송장 등록")
        }
        .padding(.bottom, 16)
    }
    
    var selectCompanyViewBackground: some View {
        Color.black.opacity(0.5)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                showSelectCompanyView = false
            }
    }
    
    var selectCompanyView: some View {
        SelectCompanyView(show: $showSelectCompanyView, selected: $text)
            .padding(.top, 100)
            .transition(.move(edge: .bottom))
    }
}

struct AddTrackingNumberView_Previews: PreviewProvider {
    static var previews: some View {
        AddTrackingNumberView()
    }
}

// Grid Numpads
/*
let columns: [GridItem] = [
    GridItem(.flexible(), spacing: nil, alignment: nil),
    GridItem(.flexible(), spacing: nil, alignment: nil),
    GridItem(.flexible(), spacing: nil, alignment: nil)
]

let numpads: [String] = [
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0", "back"
]

LazyVGrid(columns: columns) {
    ForEach(numpads, id: \.self) { content in
        Button {
            buttonPressed(content)
        } label: {
            if content == "back" {
                Image(systemName: "arrow.left")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 25, height: 20.7)
                    .font(Font.custom("Pretendard-SemiBold", size: 32.0))
                    .foregroundColor(ColorManager.defaultForeground)
            } else {
                Text(content)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .font(Font.custom("Pretendard-SemiBold", size: 32.0))
                    .foregroundColor(ColorManager.defaultForeground)
                    .padding(.vertical, 12)
//                                .background(Color.red)
            }

        }
        .disabled(content.isEmpty)
    }
}
 */

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
