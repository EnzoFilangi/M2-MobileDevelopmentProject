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
        VStack(spacing:0){
            TopTabBarButtonsContainerView(tabIndex: $tabIndex, titles: self.titles)
            ScrollView {
                if (talkViewModel.loaded) {
                    if((talkViewModel.errorMessage) != nil){
//                        Text("An error occured. Please check your internet connection.")
                        Text(talkViewModel.errorMessage!)
                    } else {
                        if(tabIndex == 0){
                            TalksListView(talks: talkViewModel.listTalks) { record in
                                return record.fields.start < Date.now && record.fields.end > Date.now
                            }
                        }
                        if(tabIndex == 1){
                            TalksListView(talks: talkViewModel.listTalks) { record in
                                return record.fields.start > Date.now
                            }
                        }
                    }
                } else {
                    ProgressView()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            talkViewModel.fetchTalks()
        }
    }
}

struct TopTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopTabBarView()
    }
}
