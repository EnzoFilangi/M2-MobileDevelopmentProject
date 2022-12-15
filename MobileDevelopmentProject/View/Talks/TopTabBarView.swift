//
//  TopTabBarView.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import SwiftUI

struct TopTabBarView: View {
    @State var tabIndex = 0
    @StateObject var talkViewModel = TalksViewModel()
    var titles = ["Right now", "Up next"]
    
    var body: some View {
        VStack{
            TopTabBarButtonsContainerView(tabIndex: $tabIndex, titles: self.titles)
            if (talkViewModel.loaded) {
                Text(talkViewModel.errorMessage ?? talkViewModel.listTalks[0].fields.activity)
            } else {
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            talkViewModel.fetchTalks()
        }
        .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .local).onEnded({ value in
            if value.translation.height > 0 {
                talkViewModel.fetchTalks()
            }
        }))
    }
}

struct TopTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopTabBarView()
    }
}
