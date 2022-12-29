//
//  MemberShipAgreementView.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import SwiftUI

struct MemberShipAgreementView: View {
    @Binding var firstNaviLinkActive: Bool
    @State var isOn1 = false
    var agreementName = ["이용약관", "개인정보 처리방침"]
    var agreementContent = ["aslfjalefjaoseifjapoeifjapo iej f paosie fjpoaisje fopiasje fawefoai" , "개인정보처리방침 뭐시기저시기 ㅁ쟏러ㅔ맺댜러ㅔ매쟈더램젇"]
    var body: some View {
//        List(0...1, id: \.self) { idx in
//            DisclosureGroup {
//                HStack {
//                    VStack {
//                        ScrollView {
//                            Text(agreementContent[idx])
//                        }
//                        .frame(height: 200)
//                    }
//
//                }
//            } label: {
//                HStack {
//                    Text(agreementName[idx])
//                    Spacer()
//                }
//            }
//        }
//    }
        HStack{
            VStack(alignment: .leading, spacing: 10) {
                Text("계정을")
                    .padding(.leading, 10)
                    .padding(.top, 20)
                    .font(.custom("Pretendard-Bold", size: 30))
                Text("만들어주세요")
                    .padding(.leading, 10)
                    .font(.custom("Pretendard-Bold", size: 30))
                Toggle("", isOn: $isOn1)
                  .toggleStyle(CheckboxToggleStyle(style: .circle))
                  .foregroundColor(ColorManager.negativeColor)
                Spacer()
            }
            Spacer()
        }
    }
}
struct CheckboxToggleStyle: ToggleStyle {
  @Environment(\.isEnabled) var isEnabled
  let style: Style // custom param

  func makeBody(configuration: Configuration) -> some View {
    Button(action: {
      configuration.isOn.toggle() // toggle the state binding
    }, label: {
      HStack {
          Image(systemName: configuration.isOn ? "checkmark.\(style.sfSymbolName).fill" : "checkmark.\(style.sfSymbolName).black")
          .imageScale(.large)
      }
    })
    .buttonStyle(PlainButtonStyle()) // remove any implicit styling from the button
    .disabled(!isEnabled)
  }

  enum Style {
    case square, circle

    var sfSymbolName: String {
      switch self {
      case .square:
        return "square"
      case .circle:
        return "circle"
      }
    }
  }
}

struct MemberShipAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        MemberShipAgreementView(firstNaviLinkActive: .constant(true))
    }
}
