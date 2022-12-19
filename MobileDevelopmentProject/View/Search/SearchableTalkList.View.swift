//
//  SearchableTalkList.View.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 19/12/2022.
//

import SwiftUI

struct SearchableTalkList: View {
    @StateObject var selectedTalkType = SelectedTalkTypeViewModel(possibleTypes: [])
    @State private var searchText = ""
    
    let talks : [APIRecord<Talk>]
    let refreshFunction : () -> Void
    
    init(talks: [APIRecord<Talk>], refreshFunction: @escaping () -> Void) {
        self.talks = talks
        self.refreshFunction = refreshFunction
    }
    
    private func extractTalkTypes(talks : [APIRecord<Talk>]) -> [String] {
        var types: [String] = []
        talks.forEach { talk in
            let type = talk.fields.type
            
            // If it is not in the list, add it
            if(!types.contains(type)){
                types.append(type)
            }
        }
        
        return types.sorted()
    }
    
    /**
     Returns true if the talk matches the search criterias
     
     Uses the value of the search bar as well as the selected talk types to make its decision : a talk is valid if it matches the search criteria and its type is selected
     */
    private func applySearch(record : APIRecord<Talk>) -> Bool {
        return searchBarCriteria(talk: record.fields, criteria: searchText) && selectedTalkType.isTalkTypeSelected(talkType: record.fields.type)
    }
    
    /**
     Returns true if the given {talk} matches the given {criteria}
     
     A talk is considered matching if one of the following conditions is true :
     - The search field is empty
     - The talk name contains the search criteria
     - One of the speakers' name contains the search criteria
     - The location contains the search criteria
     */
    private func searchBarCriteria(talk: Talk, criteria: String) -> Bool {
        return criteria == ""
        || talk.activity.lowercased().contains(criteria.lowercased())
        || (talk.speakers?.map{name in name.lowercased().contains(criteria.lowercased())} ?? []).contains(true)
        || talk.location.lowercased().contains(criteria.lowercased())
    }
    
    var body: some View {
        VStack {
            TalkTypeSelector(data: selectedTalkType)
            TalksListView(talks: talks, filter: applySearch)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Talk name, speaker, location...")
                .refreshable {
                    refreshFunction()
                }
        }.onAppear{
            selectedTalkType.possibleTypes = extractTalkTypes(talks: talks)
        }
    }
}

struct SearchableTalkList_Previews: PreviewProvider {
    static var previews: some View {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let listTalks = [
            APIRecord<Talk>(id: "1", createdTime: Date.now, fields: Talk(location: "Foo", activity: "Event 1", type: "Panel", start: formatter.date(from: "2023-02-08 09:00")!, end: formatter.date(from: "2023-02-08 10:00")!, speakers: ["Mattheus Anderson"])),
            APIRecord<Talk>(id: "2", createdTime: Date.now, fields: Talk(location: "Foo", activity: "Event 1", type: "Breakout session", start: formatter.date(from: "2023-02-08 09:00")!, end: formatter.date(from: "2023-02-08 10:00")!, speakers: ["Mattheus Anderson"])),
            APIRecord<Talk>(id: "3", createdTime: Date.now, fields: Talk(location: "Bar", activity: "Event 3", type: "Panel", start: formatter.date(from: "2023-02-08 11:00")!, end: formatter.date(from: "2023-02-08 12:00")!, speakers: ["Foo Bar"]))
        ]
        
        return NavigationStack{
            SearchableTalkList(talks: listTalks, refreshFunction: {})
        }
    }
}
