//
//  TalksView.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import SwiftUI

struct TalksView: View {
    @StateObject var talkViewModel = TalksViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: .top) {
                Color.background
                    .ignoresSafeArea()
                if(talkViewModel.errorMessage != nil || talkViewModel.httpError != nil){
                    VStack {
                        Text("😰")
                            .font(.system(size: 100))
                        Text("The list of talks couldn't be fetched, please check your internet connection.")
                            .font(.title3)
                            .foregroundColor(.main)
                            .multilineTextAlignment(.center)
                    }
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity
                    )
                    .padding()
                } else if (talkViewModel.listTalks.count > 0) {
                    TopTabBar(
                        titles: ["Right now", "Up next"],
                        TalksListView(talks: talkViewModel.listTalks) { record in
                            return record.fields.start < Date.now && record.fields.end > Date.now
                        },
                        TalksListView(talks: talkViewModel.listTalks) { record in
                            return record.fields.start > Date.now
                        }
                    )
                } else {
                    HStack{
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
            .refreshable {
                talkViewModel.fetchTalks()
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            }
            .navigationTitle("All talks")
        }
    }
}

struct TalksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TalksView()
        }
    }
}
