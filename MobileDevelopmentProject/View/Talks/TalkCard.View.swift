//
//  TalkCardView.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import SwiftUI

struct TalkCardView: View {
    let talk: Talk
    
    init(talk: Talk) {
        self.talk = talk
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(talk.formatDay())
                    .font(.caption)
                Spacer()
                Text(talk.formatHours())
                    .font(.caption)
            }
            Text(talk.activity)
                .font(.title2)
                .fontWeight(.semibold)
                .padding([.top, .bottom], 2)
            ForEach(talk.speakers ?? [], id: \.self){ speaker in
                Text(speaker)
            }
            HStack {
                Spacer()
                ColoredTextPill(text: talk.type)
            }
        }
        .padding()
        .background(Color.foreground)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 5)
    }
}

struct TalkCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TalkCardView(talk: Talk(location: "Foo", activity: "Building an alert system that works for everyone", type: "Panel", start: Date.now, end: Date.now, speakers: ["Mattheus Anderson"]))
            TalkCardView(talk: Talk(location: "Foo", activity: "Opening remarks", type: "Keynote", start: Date.now, end: Date.now, speakers: ["John Smith", "Jane Doe"]))
            TalkCardView(talk: Talk(location: "Foo", activity: "Lorem ipsum dolor sit amet", type: "Bar", start: Date.now, end: Date.now, speakers: nil))
        }.padding()
    }
}
