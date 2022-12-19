//
//  SearchView.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import SwiftUI

struct SearchView: View {
    @StateObject var talkViewModel = TalksViewModel()
    
    private func refreshTalkViewModel() -> Void {
        talkViewModel.fetchTalks()
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
    }
    
    var body: some View {
        NavigationStack{
            ZStack (alignment: .top) {
                Color.background
                    .ignoresSafeArea()
                if(talkViewModel.errorMessage != nil || talkViewModel.httpError != nil){
                    ErrorMessage("The list of talks couldn't be fetched, please check your internet connection.")
                } else if (talkViewModel.listTalks.count > 0) {
                    SearchableTalkList(talks: talkViewModel.listTalks, refreshFunction: refreshTalkViewModel)
                } else {
                    HStack{
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
            .navigationTitle("Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
