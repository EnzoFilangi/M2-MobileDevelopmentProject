//
//  TalksView.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import SwiftUI

struct TalksView: View {
    var body: some View {
        ZStack (alignment: .top) {
            Color.background
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Talks")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.main)
                    Text("All the conferences of the Home Security summit in one place")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(.main)
                        .padding(.bottom, 10)
                }
                .padding([.leading, .trailing])
                // Make the VStack take all width to be able to left-align the text
                .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  alignment: .topLeading
                )
                TopTabBarView()
            }
        }
    }
}

struct TalksView_Previews: PreviewProvider {
    static var previews: some View {
        TalksView()
    }
}
