//
//  LoadingProgressView.swift
//  acmebrowser
//
//  Created by Victor Idongesit on 13/04/2022.
//

import SwiftUI

struct LoadingProgressView: View {
    @Binding var progressPercentage: Double
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geo.size.width, height: Consts.Home.progressViewHeight, alignment: .center)
                        .foregroundColor(Color.from(.progressViewBackground))
                    Rectangle()
                        .frame(width: geo.size.width * CGFloat(progressPercentage), height: Consts.Home.progressViewHeight, alignment: .center)
                        .foregroundColor(Color.from(.progressView))
                    
                }.cornerRadius(Consts.Home.progressViewHeight/2)
            }
        }
        .frame(height: Consts.Home.progressViewHeight)
    }
}

struct LoadingProgressView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingProgressView(progressPercentage: .constant(0.5))
    }
}
