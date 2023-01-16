import SwiftUI

// MARK: - MainView

struct ExampleView: View {
    var body: some View {
        VStack {
            
            Text("리스트 테스트")
                .frame(width: 350)
                .background(Color.red)
            List {
                ForEach(1..<16) { item in
                    PackageListRowCellView()
                        .listRowSeparator(.hidden)
                        
                }
                .onDelete { index in
                    delete(index: index)
                }
            }
            .listStyle(InsetListStyle())
        }
    }
    
    func delete(index: IndexSet) {
        // DO NOTHING
    }
}

struct PackageListRowCellView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(ColorManager.background2)
                .frame(width: .infinity, height: 76)
//                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 2)
            
            HStack(spacing: 16) {
                Circle()
                    .fill(ColorManager.foreground2)
                    .frame(width:44 , height: 44)
                    .overlay(
                        Image("CJ_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 27)
                    )
                
                VStack(alignment: .leading) {
                    Text("토리든 다이브인 저분자 히알루론산 클렌징 폼 150ml")
                        .font(FontManager.title2)
                        .foregroundColor(ColorManager.defaultForeground)
                        .lineLimit(1)
                    HStack {
                        Text("123456789012")
                            .font(FontManager.caption1)
                            .foregroundColor(ColorManager.foreground1)
                        Spacer()
                        Text("12/29")
                            .font(FontManager.caption1)
                            .foregroundColor(ColorManager.foreground1)
                        Text("배송완료")
                            .font(FontManager.caption2)
                            .foregroundColor(ColorManager.primaryColor)
                    }
                }
            }
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
//        PackageListRowCellView()
    }
}
