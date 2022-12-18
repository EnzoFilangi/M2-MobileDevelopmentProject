//
//  SpeakersView.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import SwiftUI

struct SpeakersView: View {
    let names = ["Holly", "Josh", "Rhonda", "Ted"]
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack{
            ZStack (alignment: .top) {
                Color.background
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    
                }.navigationTitle("Speakers")
                    .searchable(text: $searchText)
            }
        }
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return names
        } else {
            return names.filter { $0.contains(searchText)
            }
        }
    }
}

struct SpeakersView_Previews: PreviewProvider {
    static var previews: some View {
        SpeakersView()
    }
}
