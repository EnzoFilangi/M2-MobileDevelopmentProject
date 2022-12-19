//
//  SpeakersView.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import SwiftUI

struct SpeakersView: View {
    @StateObject var speakersViewModel = SpeakersViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack (alignment: .top) {
                Color.background
                    .ignoresSafeArea()
                if(speakersViewModel.errorMessage != nil || speakersViewModel.httpError != nil){
                    VStack {
                        Text("😰")
                            .font(.system(size: 100))
                        Text("The list of speakers couldn't be fetched, please check your internet connection.")
                            .font(.title3)
                            .foregroundColor(.main)
                            .multilineTextAlignment(.center)
                    }
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity
                    )
                    .padding()
                } else if (speakersViewModel.listSpeakers.count > 0) {
                    SpeakersList(speakerRecords : speakersViewModel.listSpeakers)
                } else {
                    HStack{
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
            .refreshable {
                speakersViewModel.fetchSpeakers()
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            }
            .navigationTitle("Speakers")
        }
    }
}

struct SpeakersView_Previews: PreviewProvider {
    static var previews: some View {
        SpeakersView()
    }
}
