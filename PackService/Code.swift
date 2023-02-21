//
//  Code.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/25.
//

import Foundation

//MARK: - TrackingDetailView
/*
 //struct TrackingInfoView: View {
 //
 //
 //
 
 //
 //    var body: some View {
 //        VStack(spacing: 20) {
 ////            Text(trackingInfoVM.trackingInfo.complete)
 //            if let trackingInfo = trackingInfoVM.trackingInfo {
 //                HStack {
 //                    Text("배송 완료 여부 : ")
 //                    Spacer()
 //                    Text(trackingInfo.complete ? "Y" : "N")
 //                }
 //                .padding(.horizontal, 20)
 //
 //                HStack {
 //                    Text("운송장 번호 : ")
 //                    Spacer()
 //                    Text(trackingInfo.invoiceNo)
 //                }
 //                .padding(.horizontal, 20)
 //
 //                List {
 //                    // Identifiable 프로토콜 지우기
 //                    // (ForEach(trackingInfo.trackingDetails.indices))
 //                    // LazyVStack & LazyHStack 사용
 //                    ForEach(trackingInfo.trackingDetails) { detail in
 //                        VStack(alignment: .leading, spacing: 5) {
 //                            Text("\(detail.level)")
 //                            Text("\(detail.kind)")
 //                                .bold()
 //                        }
 //                    }
 //                }
 //            } else {
 //                Text("입력된 운송장 번호와 일치하는 정보를 찾을 수 없습니다.")
 //            }
 //
 //        }
 //
 //    }
 //}
 */

//MARK: - PREFERENCE KEY
/*
 
 extension View {
     
     func updateListGeoSize(_ size: CGSize) -> some View {
         preference(key: ListGeometryPreferenceKey.self, value: size)
     }
 }

 struct ListGeometryPreferenceKey: PreferenceKey {
     
     static var defaultValue: CGSize = .zero
     
     static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
         value = nextValue()
     }
 }
 
 */

//MARK: - COPY TO CLIPBOARD TOAST
/*
 struct CopytoClipboardToastView: View {
     @Binding var show: Bool
     
     var body: some View {
         Text("클립보드에 복사되었습니다")
             .font(FontManager.title2)
             .foregroundColor(ColorManager.defaultForegroundDisabled)
             .background(
                 RoundedRectangle(cornerRadius: 10)
                     .frame(width: UIScreen.main.bounds.width - 40, height: 55)
                     .background(.thinMaterial)
             )
             .transition(.move(edge: .bottom).combined(with: .opacity))
             .onTapGesture {
                 withAnimation {
                     self.show = false
                 }
             }
             .onAppear {
                 DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                     withAnimation(.easeInOut) {
                         show = false
                     }
                 }
             }
         
     }
 }
 */


//import SwiftUI
//import AuthenticationServices
//import FirebaseAuth
//
//struct ContentView: View {
//    @State private var status = ""
//
//    var body: some View {
//        VStack {
//            ASAuthorizationAppleIDButton()
//                .frame(width: 200, height: 50)
//                .onTapGesture {
//                    self.signInWithApple()
//                }
//
//            Text(status)
//        }
//    }
//
//    private func signInWithApple() {
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let request = appleIDProvider.createRequest()
//        request.requestedScopes = [.fullName, .email]
//
//        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
//    }
//
//    private func signInToFirebase(credential: ASAuthorizationAppleIDCredential) {
//        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: credential.identityToken, rawNonce: nonce)
//
//        Auth.auth().signIn(with: firebaseCredential) { (authResult, error) in
//            if let error = error {
//                self.status = "Firebase Sign In failed with error: \(error.localizedDescription)"
//                return
//            }
//
//            self.status = "Firebase Sign In succeeded!"
//        }
//    }
//}
//
//extension ContentView: ASAuthorizationControllerDelegate {
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        switch authorization.credential {
//        case let appleIDCredential as ASAuthorizationAppleIDCredential:
//            let userIdentifier = appleIDCredential.user
//            let fullName = appleIDCredential.fullName
//            let email = appleIDCredential.email
//
//            self.signInToFirebase(credential: appleIDCredential)
//
//        default:
//            self.status = "Sign In with Apple failed."
//        }
//    }
//
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        self.status = "Sign In with Apple failed with error: \(error.localizedDescription)"
//    }
//}
//
//extension ContentView: ASAuthorizationControllerPresentationContextProviding {
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        return NSApplication.shared.windows.last!.windowScene!.activationState == .foregroundActive ? NSApplication.shared.windows.last! : nil
//    }
//}


//    var positionArray: [String?] {
//        var positions: [String?] = Array(repeating: nil, count: 4)
//        var removeStr = "HUB|Hub|hub|물류센터|직영.*|집배점|우체국|우편집중국"
//
//        positions[0] = self.trackingDetails?.first?.detailWhere ?? "배달 전"
//        positions[1] = self.trackingDetails?.filter { $0.level <= 4 }.last?.detailWhere
//        positions[2] = self.trackingDetails?.filter { $0.level == 5 }.last?.detailWhere
//        positions[3] = self.trackingDetails?.filter { $0.level == 6 }.last?.detailWhere
//
//        for (index, position) in positions.enumerated() {
//            if let position = position {
//                var trimmed = position.replacingOccurrences(of: removeStr, with: "", options: .regularExpression)
//
//                if trimmed.count == 4 {
//                    trimmed = String(trimmed.suffix(2))
//                } else if trimmed.count == 5 {
//                    trimmed = String(trimmed.suffix(3))
//                }
//
//                positions[index] = trimmed
//            }
//        }
//
//        return positions
//    }


//// MARK: - MainTabView의 SliderTabView
//struct SliderTabView: View {
//    @State var step: Double = 1
//    init() {
//        UIPageControl.appearance().currentPageIndicatorTintColor = .black
//        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.1)
//    }
//    var body: some View {
//        let packageName: [String] = [
//            "토리든 다이브인 저분자 하알루", "2번째 택배", "3번째 택배"
//        ]
//        let packageNumber: [String] = [
//            "12345664343433", "343343545", "2453452345"
//        ]
//        let packageState: [String] = [
//            "간선상차", "간선하차", "뭐시기"
//        ]
//
//        TabView {
//            ForEach(0..<packageName.count) { item in
//                ZStack {
//                    VStack {
//                        VStack {
//
//                            HStack {
//                                Image(systemName: "gear")
//                                    .resizable()
//                                    .frame(width: 40, height: 40)
//                                VStack {
//                                    HStack {
//                                        Text(packageName[item])
//                                            .font(FontManager.title2)
//                                        Spacer()
//                                    }
//                                    HStack {
//                                        Text(packageNumber[item])
//                                            .font(FontManager.caption1)
//                                        Spacer()
//                                        Text(packageState[item])
//                                            .font(FontManager.caption1)
//                                    }
//                                }
//                                Button {
//                                    step += 1
//                                } label: {
//                                    Image(systemName: "arrow.clockwise.circle.fill")
//                                        .renderingMode(.template)
//                                        .resizable()
//                                        .frame(width: 24, height: 24)
//                                        .foregroundColor(ColorManager.primaryColor)
//                                }
//                                Spacer()
//                            }
//                            .padding(.top, 24)
//                            .padding(.leading, 16)
//                            .padding(.trailing, 34)
//
////                            HStack {
////                                ZStack(alignment: .leading) {
////                                    Rectangle()
////                                        .frame(width: 250, height: 12)
////                                        .foregroundColor(ColorManager.background2)
////                                    Image(systemName: "house.circle.fill")
////                                        .resizable()
////                                        .frame(width: 32, height: 32)
////                                        .foregroundColor(ColorManager.background2)
////                                        .background(ColorManager.foreground2)
////                                        .clipShape(Circle())
////                                        .padding(.leading, 232)
////                                    OrderButton()
////                                    Image(systemName: "shippingbox.circle.fill")
////                                        .resizable()
////                                        .frame(width: 32, height: 32)
////                                        .foregroundColor(ColorManager.primaryColor)
////                                        .background(ColorManager.background)
////                                        .clipShape(Circle())
////                                        .padding(.leading, -17)
////                                }
////                            }
////                            Spacer()
//                            VStack {
//                                Group {
//                                    TrackingProgressView2(currentStep: $step)
//                                        .frame(height: 32)
//                                        .padding(.top, 24)
//                                        .padding(.horizontal, 12)
//                                        .animation(Animation.easeIn(duration: 1.0), value: step)
//                                        .onAppear {
//                                            step = 0
//                                        }
//                                    //                        .background(Color.red)
//
//                                    var arr = ["군포", "기흥", nil, "죽전"]
//
//                                    HStack {
//                                        ForEach(arr, id: \.self) { item in
//                                            Text(item ?? "(정보없음)")
//                                                .font(FontManager.caption1)
//                                                .foregroundColor(item != arr[Int(step)] ? ColorManager.foreground1 : ColorManager.primaryColor)
//                                            //                        Text((dict[key] ?? "(정보없음)") ?? "(정보없음)")
//                                            if item != arr.last! {
//                                                Spacer()
//                                            }
//
//                                        }
//                                    }
//                                    .padding(.horizontal, 20)
//                                    .padding(.bottom, 8)
//                                }
//                            }
//                        }
//                        .background( // slideTabView 그림자 넣기
//                            ColorManager.background
//                                .cornerRadius(10)
//                                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 2)
//                        )
//
//                        Spacer()
//
//                        VStack { // 택배 상태 보여주는 탭뷰와 ... 간의 간격을 위함
//
//                        }
//                        .padding(.top, 32)
//
//                    }
//                }
//            }
//        }
//        .frame(height: 170)
//        .padding(.trailing, 20)
//        .padding(.bottom, 40)
//        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
//    }
//
//}


//// MARK: - MainTabView의 ProgressBar
//// progressbar animation
//enum OrderStatus {
//    case ready
//    case started
//    case finished
//}
//
//struct OrderButton: View {
//
//    @State private var status: OrderStatus = .ready
//
//    private var progressBarWidth: CGFloat = 250
//    private var animationTime: TimeInterval = 0.4
//    private var progressBarAnimationTime: TimeInterval = 3
//
//    @State private var isPlaced = false
//
//    var body: some View {
//        VStack {
//            ZStack {
//                HStack {
//                    Rectangle()
//                        .fill(ColorManager.primaryColor)
//                        .frame(height: 12)
//                        .animation(.linear(duration: (status == .finished) ? progressBarAnimationTime : progressBarAnimationTime))
//                    Spacer()
//                        .frame(width:(status == .ready) ? progressBarWidth : 0)
//                }
//                .frame(width: progressBarWidth)
//                
//                ZStack {
//                    VStack {
//                        HStack {
//                            Spacer()
//                                .frame(width:(status == .ready) ? 0: 250) // box 움직임을 위한 프레임
//                            
//                            TruckView()
//                                .foregroundColor(ColorManager.primaryColor)
//                                .background(ColorManager.background)
//                                .clipShape(Circle())
//                                .animation(Animation.linear(duration: (status == .started) ? progressBarAnimationTime : animationTime).delay(0))
//                            
//                            Spacer()
//                                .frame(width:(status == .ready) ? 250 : 0)
//                        }
//                        .frame(width: progressBarWidth)
//                    }
//                }
//            }
//            .frame(width: progressBarWidth)
//        }
//        .onAppear {
//            download()
//        }
//    }
//
//    func download() {
//        isPlaced.toggle()
//        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { timer in
//            status = .started
//        }
//        Timer.scheduledTimer(withTimeInterval: 4.5, repeats: false) { timer in
//            status = .finished
//        }
//    }
//
//}
//
//struct TruckView: View {
//    var body: some View {
//        ZStack {
//            Circle()
//                .fill(ColorManager.primaryColor)
//                .frame(width: 32, height: 32)
//            Image(systemName: "box.truck")
//                .resizable()
//                .foregroundColor(.white)
//                .symbolVariant(.fill)
//                .frame(width: 20.8, height: 14.9)
//        }
//    }
//}


////MARK: - ListButtonStyle
//struct ListButtonStyle: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .background(configuration.isPressed ? ColorManager.secondaryColor : .clear )
//            .cornerRadius(10)
//            .padding(.trailing, 20)
//    }
//}

//struct NormalButtonStyle: ButtonStyle {
//    func makeBody(configuration: Self.Configuration) -> some View {
//        configuration.label
//            .frame(width: 350, height: 60)
//            .font(.custom("Pretendard", size: 15))
//            .foregroundColor(.white)
//            .background(ColorManager.primaryColor)
//            .cornerRadius(50.0)
//    }
//}



//SystemButtonView(buttonType: .arrow, text: "피드백 보내기")
//Button(action: {
//    emailService.readTrackNumber()
//    print("systemtabview : \(emailService.trackInfo)")
//}, label: {
//    Text("테스트")
//})
//Button(action: {
//    emailService.logout()
//}, label: {
//    Text("로그아웃")
//})
//                    SystemButtonView(buttonType: .toggle, text: "알림설정")


// MARK: - buttonPressed()
//    func buttonPressed() {
////        focusState = nil
//        isSubmitted = true
////        validationCheck()
//
////        trackAttempt = !(isSubmitted && isValid)
//
//
//        trackingDetailVM.getTrackingInfo(selected ?? "", trackingNumber)
//
//        if trackAttempt {
//            withAnimation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
//                animationTrigger = true
//            }
//        }
//
////        else { 오류 아닐때만 등록되도록 수정해야함
////        if let selected = selected {
////            emailService.addTrackNumber(trackNumber: trackingNumber, trackCompany: selected)
////            print("추가되었다")
////        }
////        }
//        animationTrigger = false
//    }

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


//    func mapCompanyToTrackingInfo(info: TrackingInfoModel?, company: String) -> TrackingInfoModel? {
//        if let info = info {
//            let newTrackingInfo = TrackingInfoModel(complete: info.complete, level: info.level, invoiceNo: info.invoiceNo, isValidInvoice: info.isValidInvoice, itemImage: info.itemImage, itemName: info.itemName, receiverAddr: info.receiverAddr, receiverName: info.receiverName, recipient: info.recipient, senderName: info.senderName, trackingDetails: info.trackingDetails, estimate: info.estimate, productInfo: info.productInfo, company: company, status: info.status, msg: info.msg, code: info.code)
//
//            return newTrackingInfo
//        }
//
//        return nil
//    }
//
//        trackingInfoService.$trackingInfo
////            .combineLatest($company)
////            .map(mapCompanyToTrackingInfo)
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] (model) in
//                guard let model = model else { return }
//
//                self?.trackingModels.append(model)
//                print(self?.trackingModels)
//            }
//            .store(in: &cancellables)
//
        
        

//    func fetchData(info: TrackInfo) -> [TrackingInfoModel] {
//        guard let trackInfos = info.userTracksInfo else {
//            print("trackinfo")
//            return []
//        }
//
//        var result = [TrackingInfoModel]()
//
//        for trackInfo in trackInfos {
//            trackingInfoService.getTrackingInfo(trackInfo.trackCompany, trackInfo.trackNumber)
//
//            result.append(trackingInfoService.trackingInfo ?? TrackingInfoModel(complete: nil, level: -1, invoiceNo: nil, isValidInvoice: nil, itemImage: nil, itemName: nil, receiverAddr: nil, receiverName: nil, recipient: nil, senderName: nil, trackingDetails: nil, estimate: nil, productInfo: nil, status: nil, msg: nil, code: nil))
//        }
//
//        return result
//    }


//        guard let info = info else {
//            print("info")
//            return
//        }
//        guard let trackInfos = info.userTracksInfo else {
//            print("trackinfo")
//            return
//        }
//
//        $trackingInfoService
//            .combineLatest($info)
//            .map(generateServices)
//            .sink { [weak self] (models) in
//                self?.trackingModels = models
//            }
//            .store(in: &cancellables)
        
//        for info in trackInfos {
//            print(info.trackNumber)
//            print(info.trackCompany)
//            let service = TrackingInfoService(code: info.trackCompany, invoice: info.trackNumber)
//
//            service.getTrackingInfo(info.trackCompany, info.trackNumber)
//            service.$trackingInfo
//                .sink { [weak self] (model) in
//                    guard let track = model else {
//                        print("model fetch fail")
//                        return
//                    }
//                    self?.trackingModels.append(track)
//                }
//                .store(in: &self.cancellables)
//        }

//struct SecuredTextField: View {
//
//    @State var title: String = ""
//    @Binding var input: String
//    @Binding var wrongAttempt: Bool
//    var isFocused: FocusState<LoginUIView.TextFieldType?>.Binding
//    @Binding var animationTrigger: Bool
//
//    var body: some View {
//        ZStack {
//            SecureField("", text: $input)
//                .focused(isFocused, equals: .password)
//                .submitLabel(.return)
//                .font(FontManager.body1)
//                .foregroundColor(ColorManager.defaultForeground)
//                .tint(ColorManager.primaryColor)
//                .padding(.horizontal, 20)
//                .padding(.vertical, 18)
//                .placeholder(when: input.isEmpty) {
//                    Text(title)
//                        .padding(.leading, 20)
//                        .font(FontManager.body1)
//                        .foregroundColor(ColorManager.foreground2)
//                }
//                .background(
//                    RoundedRectangle(cornerRadius: 10)
//                        .strokeBorder(!wrongAttempt ? ColorManager.primaryColor : ColorManager.negativeColor, lineWidth: 2)
//                        .opacity(isFocused.wrappedValue == .password ? 1.0 : 0.0)
//                        .background(isFocused.wrappedValue == .password ? ColorManager.background.cornerRadius(10) : ColorManager.background2.cornerRadius(10))
//                        .animation(Animation.easeIn(duration: 0.25), value: isFocused.wrappedValue == .password)
//            )
//        }
//        .offset(x: !wrongAttempt || !animationTrigger ? 0 : -10)
//    }
//}


//struct InvalidTextFieldInputModifier: ViewModifier {
//
//    var isButtonClicked: Bool
//    var isValid: Bool
//
//    func body(content: Content) -> some View {
//        if isButtonClicked {
//            content
//                .background(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(ColorManager.negativeColor, lineWidth: 2)
//                        .background(ColorManager.background.cornerRadius(10))
//                        .offset(x: isValid ? -5 : 0)
//                        .animation(Animation.default.repeatCount(3).speed(3), value: isValid)
//                )
//        }
//
//    }
//}
