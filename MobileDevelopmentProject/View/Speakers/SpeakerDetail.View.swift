//
//  SpeakerDetail.View.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 18/12/2022.
//

import SwiftUI

struct SpeakerDetail: View {
    let speaker : Speaker
    
    init(speaker: Speaker) {
        self.speaker = speaker
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            VStack (alignment: .center) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                Text(speaker.name)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .foregroundColor(.primary)
            .frame(minWidth: 0, maxWidth: .infinity)
            HStack {
                Spacer()
                TextIconButton_View(iconName: "message.fill", title: "message"){}
                Spacer()
                TextIconButton_View(iconName: "phone.fill", title: "call"){}
                Spacer()
                TextIconButton_View(iconName: "envelope.fill", title: "e-mail"){}
                Spacer()
            }
            HStack {
                VStack (alignment: .leading) {
                    Text(speaker.company)
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(speaker.role)
                }
                Spacer()
            }
            VStack (alignment: .leading) {
                VStack (alignment: .leading) {
                    Text("Phone")
                    Text(speaker.phone)
                        .foregroundColor(.blue)
                }
                .padding([.top, .bottom], 5)
                VStack (alignment: .leading) {
                    Text("E-mail")
                    Text(speaker.email)
                        .foregroundColor(.blue)
                }
                .padding([.top, .bottom], 5)
            }
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 1)
            Spacer()
        }
        .foregroundColor(.main)
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding([.leading, .trailing])
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SpeakerDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SpeakerDetail(speaker: Speaker(name: "Mattheus Anderson", role: "CEO", company: "Home SecurTech", phone: "(123) 456-7890", email: "mattheus@email.com"))
        }
    }
}
