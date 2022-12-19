//
//  SpeakersList.View.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 18/12/2022.
//

import SwiftUI

struct SpeakersList: View {
    @State private var searchText = ""
    
    let speakerRecords: [APIRecord<Speaker>]
    
    init(speakerRecords: [APIRecord<Speaker>]) {
        self.speakerRecords = speakerRecords
    }
    
    /**
     Returns all the unique first letters of the speakers names from the given records
     */
    private func extractFirstLetters(_ speakerRecords: [APIRecord<Speaker>]) -> [String] {
        var firstLetters: [String] = []
        speakerRecords.forEach { speaker in
            // Get the first letter of the name, remove any accent and set it to a common case (upper)
            let letter = speaker.fields.name.folding(options: .diacriticInsensitive, locale: .current).uppercased().first
            
            // Ensure the letter exists
            guard let letter = letter else {
                return
            }
            
            // If it is not in the list, add it
            if(!firstLetters.contains(String(letter))){
                firstLetters.append(String(letter))
            }
        }
        return firstLetters.sorted()
    }
    
    /**
     Returns all speakers whoose name start with the given {firstLetter}
     */
    private func getRecordsWithNameWhere(firstLetter : String, speakerRecords: [APIRecord<Speaker>]) -> [APIRecord<Speaker>]{
        return speakerRecords.filter { speaker in
            speaker.fields.name.first == firstLetter.first
        }
    }
    
    /**
     Returns all speaker records whose name match the search criteria
     */
    private func filterFromSearch(_ speakerRecords: [APIRecord<Speaker>]) -> [APIRecord<Speaker>]{
        // If the is no search criteria, don't filter
        if (searchText == ""){
            return speakerRecords
        }
        
        return speakerRecords.filter { record in
            record.fields.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        let filteredRecords = filterFromSearch(speakerRecords)
        
        ScrollView{
            VStack(alignment: .leading){
                ForEach(
                    extractFirstLetters(filteredRecords),
                    id: \.self)
                { letter in
                    VStack{
                        HStack{
                            Text(letter)
                                .font(.headline)
                                .foregroundColor(.main)
                            Spacer()
                        }
                        Divider()
                        ForEach(
                            getRecordsWithNameWhere(
                                firstLetter: letter,
                                speakerRecords: filteredRecords
                            ),
                            id: \.id)
                        { record in
                            NavigationLink(destination: SpeakerDetail(speaker: record.fields)){
                                SpeakerCard(record.fields)
                                    .padding([.top, .bottom], 1)
                            }
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
            .padding()
            .frame(
                minWidth: 0,
                maxWidth: .infinity
            )
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}

struct SpeakersList_View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SpeakersList(speakerRecords: [
                APIRecord<Speaker>(id: "1", createdTime: Date.now, fields: Speaker(name: "Mattheus Anderson", role: "CEO", company: "Home SecurTech", phone: "(123) 456-7890", email: "mattheus@email.com")),
                APIRecord<Speaker>(id: "2", createdTime: Date.now, fields: Speaker(name: "Deepa Vartak", role: "Head of product", company: "Playpen.io", phone: "(123) 456-7890", email: "deepa@email.com")),
                APIRecord<Speaker>(id: "3", createdTime: Date.now, fields: Speaker(name: "Aeepa Vartak", role: "Head of product", company: "Playpen.io", phone: "(123) 456-7890", email: "deepa@email.com")),
                APIRecord<Speaker>(id: "3", createdTime: Date.now, fields: Speaker(name: "Beepa Vartak", role: "Head of product", company: "Playpen.io", phone: "(123) 456-7890", email: "deepa@email.com")),
                APIRecord<Speaker>(id: "3", createdTime: Date.now, fields: Speaker(name: "Deepa Vartak", role: "Head of product", company: "Playpen.io", phone: "(123) 456-7890", email: "deepa@email.com")),
                APIRecord<Speaker>(id: "3", createdTime: Date.now, fields: Speaker(name: "Ceepa Vartak", role: "Head of product", company: "Playpen.io", phone: "(123) 456-7890", email: "deepa@email.com")),
                APIRecord<Speaker>(id: "3", createdTime: Date.now, fields: Speaker(name: "Eepa Vartak", role: "Head of product", company: "Playpen.io", phone: "(123) 456-7890", email: "deepa@email.com")),
                APIRecord<Speaker>(id: "3", createdTime: Date.now, fields: Speaker(name: "Feepa Vartak", role: "Head of product", company: "Playpen.io", phone: "(123) 456-7890", email: "deepa@email.com")),
            ])
        }
    }
}
