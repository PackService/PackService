//
//  SystemTabView.swift
//  PackService
//
//  Created by 이범준 on 1/9/23.
//

import SwiftUI

struct SystemTabView: View {
    @State var serviceAgreeScreen = false
    var body: some View {
            VStack {
                if serviceAgreeScreen {
                    Color.white // 이것 때문에 밑으로 내려가네 수정 필ㄷ요
                        .edgesIgnoringSafeArea(.all)
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Button(action: {
                                    serviceAgreeScreen.toggle()
                                    print("서비스 이용약관 켜짐")
                                }, label: {
                                    Image(systemName: "xmark")
                                        .font(.largeTitle)
                                })
                                Text("나의택배앱 서비스 이용약관")
                            }
                            ScrollView {
                                Text("제1조 (목 적)\n본 이용약관(이하 \"약관\"이라 합니다)은 택배조회서비스(이하 \"회사\"라 합니다)가 운영하는 \"택배 배송정보 제공 서비스\"(이하 \"서비스\"라 합니다)를 \"이용자\"가 이용함에 따르는 이용조건 및 절차 등을 규정하는 데 그 목적이 있습니다.\n\n제2조 (용어의 정의) \n본 \"약관\"에서 사용하는 용어의 정의는 다음과 같습니다.\n1항\n \"택배 배송정보 제공 서비스\"란 유무선망을 통한 푸시 알림, 혹은 송장번호 조회 등의 방법을 통해 \"이용자\"가 주문한 택배의 배송 진행 상태에 관한 정보를 제공하는 \"서비스\"입니다.\n2항\n\"서비스\"는 \"스마트택배\"란 명칭의 프로그램을 통해서 제공됩니다.\n3항\n\"이용자\"란 \"스마트택배\" 프로그램을 \"이용자\" 본인 명의의 스마트폰 및/또는 본인 소유의 특정 운영체제를 탑재한 모바일 기기(이하 \"모바일 기기\"라 합니다)에 설치하고 이용하는 자를 의미합니다.\n4항\n\"회원\"이란 \"이용자\" 중 \"서비스\"의 일정한 기능을 이용하기 위해 사용자 이름(실명을 확인하지 않습니다), 아이디(이메일 주소), 비밀번호, 성별/연령/주소 등의 추가 정보를 입력하고 \"서비스\"를 이용하는 자를 의미합니다. 이하에서 \"이용자\"라 함은 \"회원\"과 \"이용자\"를 모두 포함하는 의미로 사용되며, 특별히 이를 구분할 필요가 있는 경우 \"회원\"과 \"이용자\"를 따로 표기합니다.\n5항\n\"콘텐츠\"란 \"서비스\" 내에서 \"이용자\"가 생성하거나 접하게 되는 모든 정보, 데이터, 텍스트, 사진, 위치 정보, 동영상, 오디오클립, 댓글, 소프트웨어, 스크립트, 그래픽, URL이 포함되지만 이에 한정되지 않습니다.\n\n제3조 (약관의 게시 및 변경)\n1항\n\"회사\"는 본 \"약관\"의 내용을 \"이용자\"가 쉽게 확인할 수 있도록 해당 \"서비스\" 내에 게시하거나 기타의 방법으로 고지합니다.\n2항\n\"회사\"는 \"약관의규제에관한법률\", \"정보통신망이용촉진및정보보호등에관한법률\" 등 관련법을 위배하지 않는 범위에서 본 \"약관\"을 개정할 수 있습니다.\n3항\n\"회사\"가 \"약관\"을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행 \"약관\"과 함께 제1항의 방식에 따라 그 개정 \"약관\"의 적용일자 7일 전부터 적용일자 전일까지 공지합니다.\n4항\n\"회사\"가 전 항에 따라 개정 \"약관\"을 공지할 때에 \"이용자\"가 명시적으로 거부의 의사표시를 하지 않거나 \"서비스\" 이용 계약을 해지하지 않는 경우 \"이용자\"가 개정 \"약관\"에 동의한 것으로 봅니다.\n5항\n\"회사\"가 \"이용자\"에게 \"약관\"의 변경을 고지했음에도 불구하고 \"이용자\"가 변경된 \"약관\"에 대한 정보를 알지 못하여 발생하는 피해에 대하여 \"회사\"는 책임지지 않습니다.\n6항\n본 \"약관\"은 \"회사\"와 \"이용자\" 간에 성립되는 \"서비스\" 이용 계약의 기본약정입니다. \"회사\"는 필요한 경우 특정 서비스에 관하여 적용될 사항(이하 \"개별약관\"이라고 합니다)을 정하여 미리 공지할 수 있습니다. \"이용자\"가 이러한 \"개별약관\"에 동의하고 특정 서비스를 이용하는 경우에는 \"개별약관\"이 우선적으로 적용되고, 본 \"약관\"은 보충적인 효력을 갖습니다.\n\n제4조 (약관의 해석)\n본 \"약관\"에 명시되지 아니한 사항에 대해서는 관계 법령에서 정한 바에 따라서 해석 적용됩니다.\n\n제5조 (회사의 의무)\n1항\n\"회사\"는 계속적이고 안정적인 \"서비스\"의 제공을 위하여 노력하며, 인프라, 설비 등에 문제가 발생한 때에는 부득이한 사유가 없는 한 지체 없이 수리 또는 복구합니다.")
                                    .padding(.leading, 10)
                                    .font(.custom("Pretendard-Light", size: 13))
                                Spacer()
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                } else {
                Button(action: {
                    serviceAgreeScreen.toggle()
                }, label: {
                    SystemButtonView(buttonType: .arrow, text: "이용약관")
                })
            }
            Spacer()
        }
//        VStack {
//                Text("설정")
//                    .font(FontManager.title2)
//                VStack(spacing: 10) {
//                    SystemButtonView(buttonType: .arrow, text: "계정", email: "abc@naver.com")
//                    SystemButtonView(buttonType: .toggle, text: "알림설정")
//                    Button(action: {
//                        serviceAgreeScreen.toggle()
//                    }, label: {
//                        SystemButtonView(buttonType: .arrow, text: "이용약관")
//                    })
//                    .foregroundColor(.black)
//                    SystemButtonView(buttonType: .arrow, text: "개인정보처리방침")
//                    SystemButtonView(buttonType: .version, text: "현재 버전")
//                    SystemButtonView(buttonType: .arrow, text: "피드백 보내기")
//                }
//                .padding(.top, 26)
//                Spacer()
//            }
//        }
//        .padding(.trailing, 20)
    }
}

struct SystemButtonView: View {
    
    @State private var alarmToggle = true
    var buttonType: ButtonType
    var text: String
    var email: String?
    var version: String?
    
    enum ButtonType {
        case arrow
        case toggle
        case version
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 48)
                .foregroundColor(ColorManager.background2)
                .cornerRadius(10)
            HStack {
                Text(text)
                    .padding(.leading, 20)
                    .font(FontManager.body2)
                Spacer()
                switch buttonType {
                case .arrow:
                    Text(email ?? "")
                        .padding(.trailing, 14.9)
                        .font(FontManager.body2)
                        .foregroundColor(ColorManager.primaryColor)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 10.1, height: 17.6)
                        .padding(.trailing, 26.9)
                case .toggle:
                    Toggle("", isOn: $alarmToggle)
                        .padding(.trailing, 20)
                case .version:
                    Text(version ?? "0.0.1")
                        .padding(.trailing, 20)
                        .font(FontManager.body2)
                        .foregroundColor(ColorManager.primaryColor)
                }
            }
        }
    }
}

struct SystemTabView_Previews: PreviewProvider {
    static var previews: some View {
        SystemTabView(serviceAgreeScreen: false)
    }
}
