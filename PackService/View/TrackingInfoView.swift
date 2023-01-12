//
//  TrackingInfoView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/26.
//

import SwiftUI

struct TrackingInfoView: View {
    @State var showMenu: Bool? = false
    
    var body: some View {
        ZStack {
            ScrollView {
                ZStack {
                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            Circle()
                                .fill(ColorManager.defaultForegroundDisabled)
                                .frame(width: 54, height: 54)
                                .overlay(
                                    Image("CJ_logo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 39.7, height: 34.1)
                                )
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("토리든 다이브인 저분자 히알루론산 클렌징 폼 150ml")
                                    .font(FontManager.title2)
                                    .frame(maxWidth: 233, alignment: .leading)
            //                        .background(Color.red)
                                HStack(spacing: 8) {
                                    Text("CJ 대한통운")
                                    Text("123456789012")
                                }
                                .font(FontManager.caption1)
                                .foregroundColor(ColorManager.foreground1)
                            }
                                
                            Spacer()
                        }
                        
                        VStack(spacing: 10) {
                            HStack(spacing: 10) {
                                TrackingInfoCardView(title: "받는 분", content: "박*환")
                                TrackingInfoCardView(title: "보내는 분", content: "토*든")
                            }
                            
                            HStack(spacing: 10) {
                                TrackingInfoCardView(title: "배송기사", content: "홍길동", deliveryman: true, show: $showMenu)
                                TrackingInfoCardView(title: "예상 완료 시간", content: nil)
                            }
                        }
                        
                        PromotionView(promotionTitle: "광고란", promotionContent: "광고입니다.")
                            .padding(.vertical, 8)
                        
                        TrackingPositionView()
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal, 20)
                        
                }
                .frame(maxHeight: .infinity)
            }
            
            if showMenu ?? false {
                MenuView(show: $showMenu)
                    .animation(Animation.easeIn(duration: 2), value: showMenu)
            }
        }
        
        
    }
}

struct TrackingInfoCardView: View {
    var title: String
    var content: String?
    var deliveryman: Bool = false
    @Binding var show: Bool?
    
    init(title: String, content: String? = nil, deliveryman: Bool = false, show: Binding<Bool?> = .constant(nil)) {
        self.title = title
        self.content = content
        self.deliveryman = deliveryman
        self._show = show
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(ColorManager.background2)
                .frame(width: 170, height: 88)
                            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(FontManager.caption2)
                    .foregroundColor(ColorManager.foreground1)
                
                HStack {
                    Text(content ?? "정보 없음")
                        .font(FontManager.body1)
                        .foregroundColor(content != nil ? .black : ColorManager.foreground2)
                    
                    if deliveryman {
                        Button {
                            withAnimation(Animation.easeIn(duration: 0.2)) {
                                show?.toggle()
                            }
                            
                        } label: {
                            
                            Image(systemName: "phone.circle.fill")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(ColorManager.primaryColor)

                        }
                    }
                }
                
            }
            .padding(.leading, 20)
        }

        
    }
}

struct MenuView: View {
    @Binding var show: Bool?
    
    init(show: Binding<Bool?> = .constant(nil)) {
        self._show = show
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    show = false
                }
            
            RoundedRectangle(cornerRadius: 16)
                .fill(ColorManager.background)
                .frame(width: 302, height: 204)
                .overlay(
                    VStack(spacing: 0) {
                        Button {
                            
                        } label: {
                            HStack {
                                Spacer()
                                Text("010-1234-5678 메세지 보내기")
                                    .font(FontManager.body2)
                                    .foregroundColor(ColorManager.defaultForeground)
                                Spacer()
                            }
                            .frame(height: 68)
                        }
                        
                        Divider()
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Spacer()
                                Text("010-1234-5678 전화하기")
                                    .font(FontManager.body2)
                                    .foregroundColor(ColorManager.defaultForeground)
                                Spacer()
                            }
                            .frame(height: 68)
                        }
                        
                        Divider()
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Spacer()
                                Text("기사님 번호 클립보드에 저장")
                                    .font(FontManager.body2)
                                    .foregroundColor(ColorManager.defaultForeground)
                                Spacer()
                            }
                            .frame(height: 68)
                        }
                    }
                
                )
        }
//        .frame(minHeight: .infinity)
    }
}

struct TrackingPositionView: View {
    @State var step: Double = 1
    @State var showList: Bool = false
//    @State var listSize: CGSize = .zero
    @Environment(\.defaultMinListRowHeight) var minRowHeight

    
    var body: some View {
        
        VStack(spacing: 8) {
            HStack {
                Text("택배 위치")
                    .font(FontManager.title1)
                
                Spacer()
                
                Button {
                    step += 1
                } label: {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(ColorManager.primaryColor)
                }
            }
        
            ZStack {
                ColorManager.background
                    .cornerRadius(10)
//                    .frame(width: 350, height: 152)
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 2)
                    
                
                VStack {
                    Group {
                        TrackingProgressView(currentStep: $step)
                            .frame(height: 32)
                            .padding(.top, 24)
                            .padding(.horizontal, 12)
                            .animation(Animation.easeIn(duration: 1.0), value: step)
                            .onAppear {
                                step = 0
                            }
    //                        .background(Color.red)
                        
                        var arr = ["군포", "기흥", nil, "죽전"]

                        HStack {
                            ForEach(arr, id: \.self) { item in
                                Text(item ?? "(정보없음)")
                                    .font(FontManager.caption1)
                                    .foregroundColor(item != arr[Int(step)] ? ColorManager.foreground1 : ColorManager.primaryColor)
        //                        Text((dict[key] ?? "(정보없음)") ?? "(정보없음)")
                                if item != arr.last! {
                                    Spacer()
                                }
                                
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                    }
//                    .background(Color.yellow)
                    
                    Spacer()
                    
                    //MARK: - List
                    if showList {
                        VStack {
                            ForEach(1..<16) { index in
                                TrackingPositionListCellView(status: "집화처리", position: "군포직영", deliveryMan: "홍길동", time: "\(index)", date: "2022.11.22", isCurrent: true)
                                    .padding(.vertical, 8)
                            }
                        }
                        .padding(.vertical, 16)
                        .padding(.horizontal, 16)
                    }
                    
                    Button {
                        showList.toggle()
                    } label: {
                        HStack {
                            Text(showList ? "간략히 보기" : "자세히 보기")
                                .font(FontManager.body2)
                            
                            Image(systemName: showList ? "chevron.up" : "chevron.down")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .foregroundColor(ColorManager.foreground2)
                    }
                    .overlay (
                        Rectangle()
                            .fill(ColorManager.background2)
                            .frame(height: 2)
                        , alignment: .top
                    )

                }
                
            }
//            .frame(height: 152)
//            .onPreferenceChange(ListGeometryPreferenceKey.self) { value in
//                self.listSize = value
//            }
            
            
        }
        
    }
}

//MARK: - ProgressView
struct TrackingProgressView: View {
    @Binding var currentStep: Double
    
    var body: some View {
        ProgressView("Loading...", value: currentStep, total: 3)
            .progressViewStyle(TrackingProgressViewStyle(value: $currentStep))
    }
}

//MARK: - ProgressView Style
struct TrackingProgressViewStyle: ProgressViewStyle {
    @Binding var value: Double
    
    func makeBody(configuration: Configuration) -> some View {
        
        return GeometryReader { geometry in
            let offset = geometry.size.width / 3 * value
            
            VStack {
                ZStack(alignment: .leading) {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 32)
                            .fill(ColorManager.background2)
                            .frame(width: geometry.size.width, height: 32)

                        RoundedRectangle(cornerRadius: 32)
                            .frame(width: value == 0 ? 40 : CGFloat(configuration.fractionCompleted ?? 0) * geometry.size.width, height: 32)
                            .foregroundColor(ColorManager.primaryColor)
                    }
                    
                    RoundedRectangle(cornerRadius: 32)
                        .fill(ColorManager.primaryColor)
                        .frame(width: 40, height: 32)
                        .overlay(
                            Image(systemName: "box.truck.fill")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundColor(ColorManager.background)
                        )
                        .offset(x: value != 3 ? (offset - (value == 0 ? 0 : 30)) : geometry.size.width - 40)
                }
            }
        }
        
    }

}

//MARK: - List Cell
struct TrackingPositionListCellView: View {
    
    var status: String
    var position: String
    var deliveryMan: String? = nil
    var time: String
    var date: String
    var isCurrent: Bool = false
    @State var scale = 1.0
    
    var body: some View {
        HStack(alignment: .top) {
            Circle()
                .fill(ColorManager.primaryColor)
                .frame(width: 8, height: 8, alignment: .top)
                .scaleEffect(scale)
                .padding(.top, 8)
                .padding(.horizontal, 4)
                .onAppear {
                    if isCurrent {
                        withAnimation(Animation.easeIn(duration: 0.7).repeatForever(autoreverses: true)) {
                            scale = 1.3
                        }
                    }
                }
            
            leftColumn
            
            Spacer()
            
            rightColumn
        }
        
    }
}

extension TrackingPositionListCellView {
    var leftColumn: some View {
        VStack(alignment: .leading) {
            Text(status)
                .font(FontManager.body2)
                .foregroundColor(ColorManager.defaultForeground)
            HStack {
                Text(position)
                    
                if let deliveryMan = deliveryMan {
                    Text("(\(deliveryMan))" )
                }
            }
            .font(FontManager.caption1)
            .foregroundColor(ColorManager.foreground1)
            
        }
    }
    
    var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(time)
                .font(FontManager.body2)
                .foregroundColor(ColorManager.defaultForeground)
            Text(date)
                .font(FontManager.caption1)
                .foregroundColor(ColorManager.foreground1)
        }
    }
}

extension View {
    
    func updateListGeoSize(_ size: CGSize) -> some View {
        preference(key: ListGeometryPreferenceKey.self, value: size)
    }
}

//MARK: - Preference Key
struct ListGeometryPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}


//MARK: - Previews
struct TrackingInfoView_Previews: PreviewProvider {

    static let companyIdPreview = "04"
    static let invoiceNumberPreview = "1111111111"

    static var previews: some View {
        
        Group {
            TrackingInfoView()
            TrackingPositionListCellView(status: "집화처리", position: "군포직영", deliveryMan: "홍길동", time: "07:48", date: "2022.11.22", isCurrent: true)
        }
        
//        TrackingInfoCardView(title: "받는 분", content: "박*환")
    }
}

//struct TrackingInfoLoadingView: View {
//    @Binding var companyId: String
//    @Binding var invoiceNumber: String
//
//    var body: some View {
//        TrackingInfoView(companyId: companyId, invoiceNumber: invoiceNumber)
//    }
//
//}

//struct TrackingInfoView: View {
//
//    @StateObject private var trackingInfoVM: TrackingInfoService
//
//    init(companyId: String, invoiceNumber: String) {
//        _trackingInfoVM = StateObject(wrappedValue: TrackingInfoService(companyId, invoiceNumber))
//    }
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


