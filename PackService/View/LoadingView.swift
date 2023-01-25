//
//  LoadingView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            //background
            background
            
            ProgressView()
        }
    }
}

extension LoadingView {
    //MARK: - Background
    var background: some View {
        ColorManager.defaultForegroundDisabled.opacity(0.05)
            .ignoresSafeArea()
            .background(.thinMaterial)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
