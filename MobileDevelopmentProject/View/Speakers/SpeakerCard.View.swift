//
//  SpeakerCard.View.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 18/12/2022.
//

import SwiftUI

struct SpeakerCard: View {
    let speaker : Speaker
    
    init(_ speaker: Speaker) {
        self.speaker = speaker
    }
    
    var body: some View {
        HStack{
            Text(speaker.name)
                .foregroundColor(.main)
            Spacer()
        }
    }
}

struct SpeakerCard_View_Previews: PreviewProvider {
    static var previews: some View {
        SpeakerCard(Speaker(name: "Mattheus Anderson", role: "CEO", company: "Home SecurTech", phone: "(123) 456-7890", email: "mattheus@email.com"))
    }
}
