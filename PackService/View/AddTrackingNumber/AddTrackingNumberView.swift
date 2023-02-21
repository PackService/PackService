//
//  AddTrackingNumberView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/22.
//

import SwiftUI

//MARK: - AddTrackingNumberView
struct AddTrackingNumberView: View {
    
    @Binding var firstNaviLinkActive: Bool
    @EnvironmentObject var service: LoginService
    
    @Environment(\.dismiss) private var dismissAddTrackingNumberView
    @StateObject var recommendVM = RecommendService("")
//    @State var selectedCompany = Recommend(id: "", international: "", name: "")
    @State var invoice: String = ""
    
    ///////
    @State var isValid: Bool = false
    @State var trackAttempt: Bool = false
    @State var isSubmitted: Bool = false
    @State var animationTrigger: Bool = false
    ///////

    @FocusState var focusState: TextFieldType?
    @State var text: String? = nil
    @State var selected: String? = nil
    
    @State var showSelectCompanyView: Bool = false
    
    @StateObject var trackingDetailVM = TrackingInfoService(company: "", invoice: "")
    
    @State var errorMessage: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        
        ZStack {
            //Background
            background
            
            //Content
            VStack(alignment: .leading, spacing: 16) {
                //Tracking Number TextField
                trackingNumberTextField
                
                //Select Company Button
                selectCompanyButton
                
                //Recommend Capsules
                companyCapsuleList

                Spacer()
                
                //Add Button
                addTrackingNumberButton
                
                //Logic For Handling Errors
                Text(errorMessage)
                    .onChange(of: trackingDetailVM.errorMessage) { newValue in
                        if service.repeatTrackNumberError == "" {
                            if newValue == "유효하지 않은 운송장번호 이거나 택배사 코드 입니다." {
                                errorMessage = trackingDetailVM.errorMessage
                                showAlert = true
                            } else {
                                firstNaviLinkActive = false
                                service.addTrackNumber(company: selected ?? "", invoice: invoice)
                            }
                        } else {
                            errorMessage = service.repeatTrackNumberError
                            showAlert = true
                        }
                        print("newValue는 \(newValue)")
                        print("반복에러 : \(service.repeatTrackNumberError)")
                    }
                    .frame(width: 0, height: 0)
            }
            .padding(.horizontal, 20)
            .padding(.top, 41)
            .alert("오류", isPresented: $showAlert) {
                Button("OK") {}
            } message: {
                Text(errorMessage)
            }
            
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
    }
    
    //MARK: - Logic for Capsules
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
                    selected = name.id
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
    
    //MARK: - toggleFocus()
    func toggleFocus() {
        if focusState == .trackingNumber {
            focusState = nil
        }
    }

    //MARK: - selectButtonPressed()
    func selectButtonPressed() {
        showSelectCompanyView = true
    }
    
    //MARK: - capsulePressed(_:)
    func capsulePressed(_ name: String) {
        self.text = name
    }

}

extension AddTrackingNumberView {
    //MARK: - Background
    var background: some View {
        ColorManager.background
            .onTapGesture {
                focusState = nil
            }
    }
    
    //MARK: - TrackingNumberTextField
    var trackingNumberTextField: some View {
        TextFieldView(title: "운송장 번호를 입력하세요", input: $invoice, wrongAttempt: $trackAttempt, animationTrigger: $animationTrigger, isFocused: $focusState, type: .trackingNumber)
            .keyboardType(.numberPad)
            .onSubmit {
                toggleFocus()
            }
            .onChange(of: invoice) { _ in
                recommendVM.getRecommendCompanies(invoice)
            }
    }
    
    //MARK: - SelectCompanyButton
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
    
    //MARK: - CompanyCapsuleList
    var companyCapsuleList: some View {
        GeometryReader { geo in
            self.content(proxy: geo)
        }
    }
    
    //MARK: - AddTrackingNumberButton
    var addTrackingNumberButton: some View {
        Button {
            trackingDetailVM.getTrackingInfo(selected ?? "", invoice)
            service.findRepeatTrackNumber(company: selected ?? "", invoice: invoice)
        } label: {
            ButtonView(text: "운송장 등록")
        }
        .padding(.bottom, 16)
    }
    
    //MARK: - SelectCompanyViewBackground
    var selectCompanyViewBackground: some View {
        Color.black.opacity(0.5)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                showSelectCompanyView = false
            }
    }
    
    //MARK: - SelectCompanyView
    var selectCompanyView: some View {
        SelectCompanyView(show: $showSelectCompanyView, text: $text, selected: $selected)
            .padding(.top, 100)
            .transition(.move(edge: .bottom))
    }
}

//struct AddTrackingNumberView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTrackingNumberView()
//    }
//}
