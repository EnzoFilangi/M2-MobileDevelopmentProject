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
                Text("Talks")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.main)
                Text("All the conferences of the Home Security summit in one place")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(.main)
            }
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .topLeading
                )
            .padding()
        }
    }
}

struct TalksView_Previews: PreviewProvider {
    static var previews: some View {
        TalksView()
    }
}
