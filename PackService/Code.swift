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