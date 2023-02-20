//
//  ServiceAgreeDescriptView.swift
//  PackService
//
//  Created by 이범준 on 12/30/22.
//

import SwiftUI

struct ServiceAgreeDescriptView: View {
    @Binding var serviceAgreeScreen: Bool
    let serviceAgreeContent = ServiceAgreeContent()
    
    var body: some View {
        Color.white
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
                    ForEach((0...17), id: \.self) {index in
                        VStack {
                            HStack {
                                Text(serviceAgreeContent.title[index])
                                    .font(FontManager.title3)
                                Spacer()
                            }
                            
                            HStack {
                                Text(serviceAgreeContent.content[index])
                                    .font(FontManager.body2)
                                Spacer()
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    
                }
                Spacer()
            }
            Spacer()
        }
    }
}

struct NavigationServiceAgreeView: View {
    @State private var showNavigationBar = false
    let serviceAgreeContent = ServiceAgreeContent()
    var body: some View {
        VStack {
            ScrollView {
                ForEach((0...17), id: \.self) {index in
                    VStack {
                        HStack {
                            Text(serviceAgreeContent.title[index])
                                .font(FontManager.title3)
                            Spacer()
                        }
                        
                        HStack {
                            Text(serviceAgreeContent.content[index])
                                .font(FontManager.body2)
                            Spacer()
                        }
                    }
                    .padding(.bottom, 20)
                }
                
            }
            .padding(.vertical, 20)
            .navigationBarTitle("서비스 이용약관", displayMode: .inline)
            Spacer()
        }
        .onDisappear(perform: {
            // 뷰가 나타날떄 수행 할 코드
            showNavigationBar = true
        })
        .toolbar(showNavigationBar ? .visible : .hidden, for: .tabBar)
        .padding(.horizontal, 20)
    }
}

struct ServiceAgreeContent {
    let title = ["제1조 (목 적)", "제2조 (용어의 정의)", "제3조 (약관의 게시 및 변경)", "제4조 (약관의 해석)", "제5조 (회사의 의무)" , "제6조 (\"이용자\"의 의무)", "제7조 (서비스의 제공 등)", "제8조 (서비스의 변경)", "제9조 (정보의 제공 및 광고의 게재)", "제10조 (서비스 이용 계약 체결)", "제11조 (회원의 아이디의 관리에 대한 의무)", "제12조 (회원의 계정에 대한 관리)", "제13조 (서비스 이용 계약의 해지)", "제14조 (책임제한)", "제15조 (콘텐츠의 이용)", "제16조 (해외이용)", "제17조(준거법 및 재판관할)","부칙"]
    let content = ["본 이용약관(이하 \"약관\"이라 합니다)은 회사가 운영하는 \"택배 배송정보 제공 서비스\"(이하 \"서비스\"라 합니다)를 \"이용자\"가 이용함에 따르는 이용조건 및 절차 등을 규정하는 데 그 목적이 있습니다.",
                   "본 \"약관\"에서 사용하는 용어의 정의는 다음과 같습니다. \n① \"택배 배송정보 제공 서비스\"란 유무선망을 통한 푸시 알림, 혹은 송장번호 조회 등의 방법을 통해 \"이용자\"가 주문한 택배의 배송 진행 상태에 관한 정보를 제공하는 \"서비스\"입니다.\n② \"서비스\"는 \"스마트택배\"란 명칭의 프로그램을 통해서 제공됩니다. \n③ \"이용자\"란 \"스마트택배\" 프로그램을 \"이용자\" 본인 명의의 스마트폰 및/또는 본인 소유의 특정 운영체제를 탑재한 모바일 기기(이하 \"모바일 기기\"라 합니다)에 설치하고 이용하는 자를 의미합니다. \n④ \"회원\"이란 \"이용자\" 중 \"서비스\"의 일정한 기능을 이용하기 위해 사용자 이름(실명을 확인하지 않습니다), 아이디(이메일 주소), 비밀번호, 성별/연령/주소 등의 추가 정보를 입력하고 \"서비스\"를 이용하는 자를 의미합니다. 이하에서 \"이용자\"라 함은 \"회원\"과 \"이용자\"를 모두 포함하는 의미로 사용되며, 특별히 이를 구분할 필요가 있는 경우 \"회원\"과 \"이용자\"를 따로 표기합니다. \n⑤ \"콘텐츠\"란 \"서비스\" 내에서 \"이용자\"가 생성하거나 접하게 되는 모든 정보, 데이터, 텍스트, 사진, 위치 정보, 동영상, 오디오클립, 댓글, 소프트웨어, 스크립트, 그래픽, URL이 포함되지만 이에 한정되지 않습니다.",
                   "① \"회사\"는 본 \"약관\"의 내용을 \"이용자\"가 쉽게 확인할 수 있도록 해당 \"서비스\" 내에 게시하거나 기타의 방법으로 고지합니다. \n② \"회사\"는 \"약관의규제에관한법률\", \"정보통신망이용촉진및정보보호등에관한법률\" 등 관련법을 위배하지 않는 범위에서 본 \"약관\"을 개정할 수 있습니다. \n③ \"회사\"가 \"약관\"을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행 \"약관\"과 함께 제1항의 방식에 따라 그 개정 \"약관\"의 적용일자 7일 전부터 적용일자 전일까지 공지합니다. \n④ \"회사\"가 전 항에 따라 개정 \"약관\"을 공지할 때에 \"이용자\"가 명시적으로 거부의 의사표시를 하지 않거나 \"서비스\" 이용 계약을 해지하지 않는 경우 \"이용자\"가 개정 \"약관\"에 동의한 것으로 봅니다. \n⑤ \"회사\"가 \"이용자\"에게 \"약관\"의 변경을 고지했음에도 불구하고 \"이용자\"가 변경된 \"약관\"에 대한 정보를 알지 못하여 발생하는 피해에 대하여 \"회사\"는 책임지지 않습니다. \n⑥ 본 \"약관\"은 \"회사\"와 \"이용자\" 간에 성립되는 \"서비스\" 이용 계약의 기본약정입니다. \"회사\"는 필요한 경우 특정 서비스에 관하여 적용될 사항(이하 \"개별약관\"이라고 합니다)을 정하여 미리 공지할 수 있습니다. \"이용자\"가 이러한 \"개별약관\"에 동의하고 특정 서비스를 이용하는 경우에는 \"개별약관\"이 우선적으로 적용되고, 본 \"약관\"은 보충적인 효력을 갖습니다.",
                   "본 \"약관\"에 명시되지 아니한 사항에 대해서는 관계 법령에서 정한 바에 따라서 해석 적용됩니다.",
                   "① \"회사\"는 계속적이고 안정적인 \"서비스\"의 제공을 위하여 노력하며, 인프라, 설비 등에 문제가 발생한 때에는 부득이한 사유가 없는 한 지체 없이 수리 또는 복구합니다. \n② \"회사\"는 \"이용자\"로부터 제기되는 의견이나 불만이 정당하다고 객관적으로 인정될 경우에는 적절한 절차를 거쳐 처리합니다. 다만, 처리가 곤란한 경우는 \"이용자\"에게 그 사유와 처리 계획을 통보합니다. \n③ \"회사\"는 \"이용자\"가 안전하게 서비스를 이용할 수 있도록 \"이용자\"의 개인정보 보호를 위해 보안시스템을 갖추며, 개인정보처리방침을 공시하고 준수합니다.",
                   "① \"이용자\"는 \"서비스\"를 이용할 경우, \"서비스\"의 원활한 이용을 위해 쇼핑몰에 제공한 \"모바일 기기\"의 전화번호와 동일한 번호를 \"회사\"에게 제공하여야 합니다. \n② \"이용자\"는 \"회사\"와 정당한 계약 또는 허락 없이 \"서비스\" 및/또는 \"서비스\"에서 제공되는 \"콘텐츠\"를 재판매 할 수 없고, 이를 이용하여 영리 활동을 할 수 없으며, \"이용자\"가 본 \"약관\"에 위반한 영리 활동을 하여 발생한 결과에 대하여 \"회사\"는 책임을 지지 않습니다. \n③ \"이용자\"는 \"서비스\"의 이용권한, 기타 본 \"약관\" 또는 \"개별약관\" 상의 지위, 권리를 타인에게 판매/양도, 대여, 증여, 담보 제공할 수 없습니다. \n④ \"이용자\"는 \"서비스\" 이용과 관련하여 다음의 행위를 해서는 안됩니다. \n1.  본 약관에서 규정하는 사항과 기타 \"회사\"가 정한 제반 규정, 공지사항 등 \"회사\"가 정한 사항 및/또는 관계법령을 위반하는 행위 \n2.  \"회사\"의 업무에 방해가 되는 행위, \"회사\"의 명예 또는 신용을 손상시키는 행위 \n3.  \"회사\" 및/또는 제3자의 저작권 등 지적재산권을 침해하는 행위 \n4.  배포된 \"스마트택배\" 어플리케이션에 대해 디컴파일, 해킹, 리버스 엔지니어링 등의 방법으로 소스코드를 분석하거나 이를 임의로 분해, 복제, 모방, 삭제, 변경하는 행위 \n5. 비정상적인 방법으로 \"서비스\"를 이용하여 회사의 시스템에 부하를 발생시키거나 오류, 오작동 등을 일으켜 \"서비스\"의 정상적인 운영을 방해하는 행위 \n⑤ \"이용자\"는 본 조 제2항 내지 제4항의 의무를 위반한 것에 대하여 \"회사\"에 손해배상 의무를 집니다.",
                   "① \"회사\"는 다음 각 항의 하나 또는 하나 이상의 방법을 통해 \"이용자\"에게 \"서비스\"를 제공합니다. \n1.  \"이용자\"가 쇼핑몰에 제공한 전화번호에 기반하여 택배사로부터 택배 배송정보를 조회하고 수신하여, 이를 푸시메시지로 \"이용자\"에게 전달, 갱신 \n2.  \"이용자\"의 \"모바일 기기\"에 수신된 문자메시지(SMS, MMS 등) 및 푸시 알림메시지로부터 택배 송장번호를 인식하여 수동 혹은 자동으로 택배 배송정보를 조회하고 수신하여, 이를 푸시메시지로 \"이용자\"에게 전달, 갱신 \n3.  \"이용자\"의 운송장번호 등록에 따라 수동 혹은 자동으로 택배 배송정보를 조회하고 수신하여, 이를 푸시메시지로 \"이용자\"에게 전달, 갱신 \n4.  기타 \"회사\"가 추가 개발하거나 다른 회사와의 제휴계약 등을 통해 택배 배송정보를 \"이용자\"에게 제공 \n\n② \"이용자\"의 \"모바일 기기\"의 운영체제(이하 \"OS\"라 합니다)의 특성, \"이용자\"에 의한 \"모바일 기기\"의 기능 설정/변경 등에 의해 본 조 제1항의 \"서비스\" 중 일부 또는 전부가 제공되지 않거나 제한될 수 있습니다.\n③ \"서비스\" 이용은 \"회사\"의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간 운영을 원칙으로 합니다.\n④ 시스템 정기 점검, 임시 점검, 증설 및 교체를 위해 \"회사\"가 정한 경우, 기타 시스템 장애 또는 운영 상의 상당한 이유가 있는 경우 \"회사\"는 \"서비스\"의 제공을 일시적으로 중단하거나 제한할 수 있습니다. 이 경우 \"회사\"는 \"회사\"의 웹사이트 또는 \"서비스\" 내 공지사항 화면에 게시하는 방법으로 \"이용자\"에게 통지합니다. 다만, \"회사\"가 사전에 통지할 수 없는 부득이한 사유가 있는 경우 사후에 통지할 수 있습니다.",
                   "① 이용 감소 등으로 인한 원활한 \"서비스\" 제공의 곤란, 기술진보에 따른 차세대 서비스로의 전환 필요성, \"서비스\" 제공과 관련한 \"회사\" 정책의 변경 등 상당한 이유가 있는 경우에 \"회사\"는 \"회사\"의 판단에 따라 \"서비스\"의 전부 또는 일부를 변경 또는 중단할 수 있습니다. \n② \"회사\"는 무료로 운영되는 \"서비스\"의 일부 또는 전부를 수정, 중단, 변경, 유료로 전환할 수 있으며, 이에 대하여 \"이용자\"에게 별도의 보상을 하지 않습니다. \n③ \"서비스\"에 대한 통상적인 수준의 업데이트나 기능의 추가/변경/삭제 등에 대해서는 \"스마트택배\"의 설치 과정에서의 공지 및/또는 \"서비스\" 내 공지사항 화면에 게시함으로써 \"이용자\"에 대한 공지를 대체합니다. \n④ \"서비스\"의 내용, 이용방법, 이용시간에 대하여 중요한 변경 또는 일부 \"서비스\"의 중단 등이 있는 경우에는 변경될 내용, 사유, 일자 등을 \"회사\" 웹사이트 및/또는 \"서비스\" 내 공지사항 화면에 게시하거나, 기타 \"이용자\"가 충분히 인지할 수 있는 방법으로 7일의 기간을 두고 사전에 공지합니다. \n⑤ \"회사\"가 \"서비스\"를 전면적으로 중단하는 경우에는 \"회사\" 웹사이트 및/또는 \"서비스\" 내 공지사항 화면에 게시하거나, 기타 \"이용자\"가 충분히 인지할 수 있는 방법으로 7일의 기간을 두고 사전에 공지합니다.",
                   "① \"회사\"는 \"이용자\"에게 \"서비스\" 이용에 필요가 있다고 인정되는 각종 정보에 대해서 \"서비스\" 내 공지사항, 전자우편, 푸시메시지, 문자메시지 등의 방법으로 제공할 수 있으며 \"이용자\"는 원하지 않을 경우 수신을 거부할 수 있습니다. 또한 \"회사\"는 불특정 다수 \"이용자\"에 대한 통지의 경우 7일 이상 \"회사\" 웹사이트 및/또는 \"서비스\" 내 공지사항 화면에 게시함으로써 개별 통지에 갈음할 수 있습니다. \n② \"회사\"는 \"서비스\"의 운영과 관련하여 \"스마트택배\" 화면, 홈페이지, 전자우편, 푸시메시지, 문자메시지 등에 광고를 게재할 수 있습니다. 단, 전자우편, 푸시메시지, 문자메시지의 경우에는 \"이용자\"의 사전 동의를 받은 경우에 한하며, 광고가 게재된 전자우편, 푸시메시지, 문자메시지 등을 수신한 \"이용자\"는 언제든지 수신을 거부할 수 있습니다.",
                   "① \"서비스\"에 대한 이용 계약은 \"서비스\"를 사용하고자 하는 자가 \"스마트택배\" 프로그램을 \"모바일 기기\"에 설치하고, 약관의 내용에 동의한 후, 해당 \"모바일 기기\"의 전화번호를 입력하는 절차를 완료했을 때 체결됩니다. \n② \"이용자\"는 본 조 제1항의 \"서비스\" 이용 계약만으로도 \"서비스\"의 기본적인 기능을 이용하고 \"콘텐츠\"를 볼 수 있지만, \"서비스\"의 특정 기능을 이용하기 위해서는 추가적으로 \"서비스\"에서 사용할 사용자 이름(실명 여부를 확인하지 않습니다.), 아이디(이메일 주소), 비밀번호, 성별/연령/주소 등을 \"회사\"에 제공하고 \"회원\"의 자격을 취득하여야 합니다. \n③ \"회사\" 다음 각 호의 하나에 해당하는 경우에 대해서는 \"서비스\" 이용을 승낙하지 않거나, \"회사\"의 판단으로 \"서비스\" 이용 계약을 해지할 수 있습니다. \n1.  본인 명의의 \"모바일 기기\" 전화번호가 아닌, 타인의 명의의 전화번호를 임의 또는 무단으로 등록하는 경우 \n2.  \"서비스\" 이용 계약 체결시 허위로 정보를 기재한 경우 \n3.  14세 미만의 아동이 법정대리인의 동의를 얻지 아니한 경우 \n4.  부정한 용도나 영리를 추구할 목적으로 \"서비스\"를 이용하고자 하는 경우 \n5.  다른 \"이용자\"의 \"서비스\" 이용을 방해하거나, 다른 \"이용자\"의 정보를 임의 또는 무단으로 사용하는 경우 \n6.  공격적이거나, 저속하거나, 외설적이거나, 그 밖에 미풍양속에 저해되는 이름에 해당하는 사용자 이름 및 아이디를 사용하는 경우 \n7.  \"이용자\"가 제6조 제4항을 위반한 경우 \n8.  \"이용자\"가 이 약관에 위배되는 사유로 인하여 이전에 자격을 상실한 적이 있는 경우 \n④ \"회사\"는 기술상 또는 업무상 문제가 있을 경우에는 본 조 제1항에 따른 \"서비스\" 이용 계약 체결 및/또는 본 조 제2항에 따른 \"회원\" 가입의 승낙을 유보/거부/철회/취소할 수 있습니다. \n⑤ 본 조 제1항에 따른 \"서비스\" 이용 계약 체결 및/또는 본 조 제2항에 따른 \"회원\" 가입에 있어 \"회사\"는 \"이용자\"에게 외부기관을 통한 실명확인 및 본인인증을 요청할 수 있습니다. \n⑥ \"회사\"는 \"영화및비디오물의진흥에관한법률\" 및 \"청소년보호법\" 등 법령에 따른 등급 및 연령 준수를 위해 \"이용자\"에 따라 일부 \"서비스\"의 이용 제한이나 등급별 제한을 할 수 있습니다.",
                   "① \"회원\"의 아이디에 관한 관리 책임은 \"회원\"에게 있으며, 이를 제3자가 이용하도록 하여서는 안됩니다. \n② \"회원\"은 아이디가 도용되거나 제3자가 사용하고 있음을 인지하는 경우에는 이를 즉시 \"회사\"에 서면으로 통지하여야 하며, \"회사\"의 안내가 있는 경우에는 그에 따라야 합니다.",
                   "① \"회사\"는 관련법 및 개인정보처리방침에 의하여 그 책임을 지는 경우를 제외하고, \"회원\" 계정의 관리책임은 \"회원\"에게 있습니다. \n② \"회원\"은 자신의 \"회원\" 계정을 제3자가 이용하게 해서는 안되며, 도용 당하거나 제3자가 사용하고 있음을 인지한 경우에는 이를 즉시 \"회사\"에 서면으로 통지하여야 하며, \"회사\"의 안내가 있는 경우에는 그에 따라야 합니다. \n③ \"회원\" 계정은 \"회원\" 본인의 동의 하에 \"회원\"이 이용하는 다른 웹사이트의 회원 계정과 연동될 수 있습니다.",
                   "① \"서비스\" 이용 계약의 해지를 원하는 \"이용자\"는 언제든지 \"서비스\" 내에서 회사가 정한 절차에 따라 모든 정보를 삭제하고 탈퇴할 수 있습니다. 이 경우 해지로 인한 모든 불이익은 \"이용자\"가 부담합니다. 해지 후 \"회사\"는 \"이용자\"에게 부가적으로 제공한 각종 혜택을 회수, 취소, 삭제할 수 있습니다. \n② \"서비스\" 이용 계약이 해지된 후 관련법에 따라 \"회사\"가 \"이용자\"의 정보를 보유하는 경우를 제외하고는 해지 즉시 \"이용자\"의 모든 관련 정보는 소멸됩니다. 단, \"회사\"는 본 약관 제10조 3항에 따라 \"서비스\" 이용 계약이 해지된 \"이용자\"에 대해서는 해지일로부터 3년 동안 \"서비스\" 이용 계약의 체결을 제한하기 위하여 해지일로부터 3년 동안 해당 \"이용자\"의 정보를 보관할 수 있습니다. \n③ \"이용자\"가 \"서비스\"를 이용하는 도중, 연속해서 일(1)년 동안 \"서비스\"를 이용하기 위해 \"회사\"의 \"서비스\"에 로그인한 기록이 없는 경우 \"회사\"는 \"서비스\" 이용 계약을 해지할 수 있습니다. \n④ \"회사\"는 \"이용자\"가 \"서비스\"를 이용함에 있어서 본 약관 제6조 (\"이용자\"의 의무) 내용을 위반하거나 \"서비스\"의 정상적인 운영을 방해하는 경우 경고, 일시 정지, 직권 해지 등으로 \"서비스\"의 이용을 단계적으로 제한할 수 있습니다.",
                   "① \"회사\"는 천재지변 또는 이에 준하는 불가항력 사유 및 기타 시스템 장애 등의 사유로 인하여 정상적으로 \"서비스\"를 제공할 수 없는 경우에는 \"서비스\" 제공에 관한 책임이 면제됩니다. \n② \"회사\"는 \"회원\" 또는 \"이용자\"의 귀책사유로 인한 \"서비스\" 장애에 대하여는 책임을 지지 않습니다. \n③ \"회사\"는 무료로 제공하는 \"서비스\" 이용과 관련하여 관련법에 특별한 규정이 없는 한 \"회원\" 또는 \"이용자\"에게 손해가 생기더라도 책임지지 않습니다. \n④ \"회사\"는 제3자가 \"서비스\" 내 화면 또는 링크된 웹사이트나 모바일 프로그램 등을 통하여 광고한 제품 또는 서비스의 내용과 품질에 대해서 감시, 보증, 이행할 의무가 없으며, 이와 관련한 어떠한 책임(제조물책임을 포함하되, 이에 한정되지 않음)도 지지 아니합니다. \n⑤ \"이용자\"가 \"서비스\" 내에서 작성하는 모든 \"콘텐츠\"에 대해서는 해당 \"콘텐츠\"를 작성한 자가 모든 책임을 집니다. \n⑥ \"이용자\"가 \"서비스\" 내에서 열람한 모든 \"콘텐츠\"에 대해서는 \"이용자\" 자신이 위험을 부담하며, 그로부터 발생하는 손해나 손실에 대해서 \"이용자\" 자신이 책임을 집니다. \n⑦ \"회사\" 및 \"회사\"의 임직원 그리고 대리인은 다음 각 호의 하나로부터 발생하는 손해에 대해 책임을 지지 않습니다. \n1.  \"이용자\" 정보의 허위 또는 부정확성에 기인하는 손해 \n2.  그 성질과 경위를 불문하고 \"서비스\"에 대한 접속 및 \"서비스\"의 이용 과정에서 발생하는 개인적인 손해 \n3.  \"스마트택배\" 및 서버에 대한 제3자의 모든 불법적인 접속 또는 서버의 불법적인 이용으로부터 발생하는 손해 \n4.  서버에 대한 전송 또는 서버로부터의 전송에 대한 제3자의 모든 불법적인 개입, 방해 또는 중단 행위로부터 발생하는 손해 \n5.  \"스마트택배\" 어플리케이션에 대한 제3자의 모든 불법적인 디컴파일, 해킹, 리버스 엔지니어링 등을 통해 발생하는 손해 \n6.  제3자가 \"스마트택배\"를 이용하여 불법적으로 전송, 유포하거나 또는 전송, 유포되도록 한 모든 바이러스, 스파이웨어 및 기타 악성 프로그램으로 인한 손해 \n7.  \"이용자\"의 부주의로 설치된 악성 프로그램에 의해 발생하는 손해 \n8.  \"이용자\"가 \"스마트택배\"가 설치된 \"모바일 기기\"를 분실함으로써 발생하는 일체의 손해 \n9.  OS의 결함, 또는 \"이용자\"의 \"모바일 기기\"의 소프트웨어 및 하드웨어적 결함에 기인한 손해 \n10.  전송된 데이터의 오류 및 생략, 누락, 파괴 등으로 발생하는 손해",
                   "① \"서비스\"에 등록된 \"콘텐츠\"의 저작권 등 지적재산권은 제3자의 권리를 침해하지 않는 한, 게시자에게 속합니다. \"회사\"가 작성한 \"콘텐츠\"에 대한 저작권 등 지적재산권은 \"회사\"에 귀속됩니다. \n② \"이용자\"는 \"서비스\"를 이용함으로써 얻은 정보를 \"회사\"의 사전 서면 승인 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다. \n③ \"회사\"는 \"콘텐츠\"가 다음 각 호의 하나에 해당하는 경우 사전 통보 없이 해당 \"콘텐츠\"를 삭제하거나 해당 \"콘텐츠\"를 게시한 \"이용자\"에 대하여 \"서비스\"의 일부 또는 전부에 대한 이용 제한, \"서비스\" 이용 계약의 해지 등의 조치를 할 수 있습니다. \n1.  대한민국의 법령을 위반하는 내용을 포함하는 경우 \n2.  저작권 등 지적재산권의 침해로 제3자로부터 이의가 제기된 경우 \n3.  음란물, 허위사실에 해당하는 경우 \n4.  타인 또는 \"회사\"의 권리, 명예, 신용, 기타 정당한 이익을 침해하는 경우 \n5.  정보통신기기의 오작동을 일으킬 수 있는 악성코드 등을 포함하는 경우 \n6.  사회 공공질서나 미풍양속에 위배되는 경우 \n7.  \"서비스\"의 원활한 제공을 방해하는 것으로 판단되는 경우 \n④ \"회사\"는 \"서비스\" 내에서 \"이용자\"가 작성한 \"콘텐츠\"를 \"회사\"의 재량으로 다양한 방식으로 이용할 수 있으며, 여기에는 그 \"콘텐츠\"에 대한 공개적 표시, 재구성, 마케팅 자료, 광고 및 그 밖의 작업물에 반영, 2차 저작물 생성, 판촉 배포와 다른 사용자들의 웹 사이트, 매체 플랫폼 및 어플리케이션과 관련해서 위와 같은 행위를 하도록 해당 사용자들에게 허용하는 행위가 포함됩니다. \n⑤ \"이용자\"는 \"서비스\" 내에서 자신이 작성한 \"콘텐츠\"에 대해서 \"회사\"가 사업과 관련해서 사용, 복사, 편집, 수정, 복제, 배포, 2차 저작품 준비, 표시, 실행 및 그 밖의 방식으로 완전히 활용할 수 있도록 전세계적, 비독점적, 영구적, 로열티 및/또는 사용료가 무료이고, 서브 라이선스 부여 및 양도, 재판매가 가능한 권한을 \"회사\"에게 현재 부여하였으며, 향후에도 이를 철회하지 않을 것임을 이 약관에 대한 동의를 통해 확인합니다. \n⑥ \"회사\"는 \"이용자\"가 게시한 \"콘텐츠\"가 타인의 저작권, 기타 법령을 위반하더라도 이에 대한 어떠한 책임도 부담하지 않습니다.",
                   "\"회사\"는 \"이용자\"가 대한민국 내에서 \"서비스\"를 이용하는 것을 전제로 \"서비스\"를 제공하고 있습니다. 따라서 \"회사\"는 \"이용자\"가 대한민국의 영토 이외의 지역에서 \"서비스\"를 이용하고자 하는 경우 \"서비스\"의 품질 또는 사용성을 보장하지 않습니다. \"이용자\"가 대한민국의 영토 이외의 지역에서 \"서비스\"를 이용하고자 하는 경우 스스로의 판단과 책임에 따라서 이용 여부를 결정하여야 합니다.",
                   "① \"회사\"와 \"이용자\" 간 제기된 소송은 대한민국 법을 준거법으로 합니다. \n② \"회사\"와 \"이용자\" 간 발생한 분쟁에 관한 소송은 민사소송법 상의 관할법원에 제소합니다.",
                   "1. 이 약관은 2023년 2월 14일부터 적용됩니다."
    ]
}
