//
//  SpeakersView.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import SwiftUI

struct SpeakersView: View {
    
    var body: some View {
        NavigationStack{
            ZStack (alignment: .top) {
                Color.background
                    .ignoresSafeArea()
                SpeakersList(speakerRecords : [])
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
