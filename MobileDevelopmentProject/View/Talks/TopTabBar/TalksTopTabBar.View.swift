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
            if(talkViewModel.errorMessage != nil || talkViewModel.httpError != nil){
                Text("An error occured while getting the data. Please check your internet connection.").padding()
            } else if (talkViewModel.listTalks.count > 0) {
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
            } else {
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .refreshable {
            talkViewModel.fetchTalks()
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        }
    }
}

struct TopTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TopTabBarView()
        }
    }
}
