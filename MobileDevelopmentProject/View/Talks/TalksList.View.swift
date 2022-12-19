//
//  TalksListView.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 15/12/2022.
//

import SwiftUI

struct TalksListView: View {
    var talks : [APIRecord<Talk>]
    var filter: (APIRecord<Talk>) -> Bool
    
    init(talks: [APIRecord<Talk>], filter: @escaping (APIRecord<Talk>) -> Bool) {
        self.talks = talks
        self.filter = filter
    }
    
    var body: some View {
        let displayedTalks = talks.filter(filter)
        
        return ScrollView {
            if (displayedTalks.count < 1) {
                VStack{
                    Text("Sorry, there isn't any talk matching this criteria!")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                    Text("🙁")
                        .font(.largeTitle)
                }
                .padding([.top, .bottom], 10)
            } else {
                ForEach(displayedTalks, id: \.id) { record in
                    NavigationLink(destination: TalkDetailsView(talk: record.fields)){
                        TalkCardView(talk: record.fields)
                            .padding([.top, .bottom], 10)
                    }
                    .buttonStyle(.plain)
                }
                .padding([.leading, .trailing])
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct TalksListView_Previews: PreviewProvider {
    static var previews: some View {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let listTalks = [
            APIRecord<Talk>(id: "1", createdTime: Date.now, fields: Talk(location: "Foo", activity: "Event 1", type: "Panel", start: formatter.date(from: "2023-02-08 09:00")!, end: formatter.date(from: "2023-02-08 10:00")!, speakers: ["Mattheus Anderson"])),
            APIRecord<Talk>(id: "2", createdTime: Date.now, fields: Talk(location: "Foo", activity: "Event 1", type: "Panel", start: formatter.date(from: "2023-02-08 09:00")!, end: formatter.date(from: "2023-02-08 10:00")!, speakers: ["Mattheus Anderson"])),
            APIRecord<Talk>(id: "3", createdTime: Date.now, fields: Talk(location: "Bar", activity: "Event 3", type: "Panel", start: formatter.date(from: "2023-02-08 11:00")!, end: formatter.date(from: "2023-02-08 12:00")!, speakers: ["Mattheus Anderson"]))
        ]
        return Group {
            NavigationStack{
                TalksListView(talks: listTalks) { record in
                    let date = formatter.date(from: "2023-02-08 09:15")!
                    return record.fields.start < date && record.fields.end > date
                }
            }
            NavigationStack{
                TalksListView(talks: listTalks) { record in
                    let date = formatter.date(from: "2023-02-08 11:15")!
                    return record.fields.start < date && record.fields.end > date
                }
            }
            NavigationStack{
                TalksListView(talks: listTalks) {record in false}
            }
        }
    }
}
