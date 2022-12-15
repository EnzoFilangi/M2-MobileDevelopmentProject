//
//  TalksViewModel.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import Foundation

class TalksViewModel: ObservableObject {
    
    private var talkSpeakersMap: [String: [String]] = [:]
    
    @Published var loaded = false
    @Published var httpError: HttpError? = nil
    @Published var errorMessage: String? = nil
    @Published var listTalks: [APIRecord<Talk>] = []
    
    func fetchTalks() -> Void {
        setLoading()
        
        // Get all talks, sorted ascending on the "Start" column
        let url = "https://api.airtable.com/v0/appLxCaCuYWnjaSKB/%F0%9F%93%86%20Schedule?sort%5B0%5D%5Bfield%5D=Start"
               
        DataSource.get(url: url, callback: self.saveCallResult)
    }
    
    private func saveCallResult(error: (errorType: HttpError?, errorMessage: String?), records: [APIRecord<Talk>]?) -> Void {
        DispatchQueue.main.async {
            if error.errorType == nil, error.errorMessage == nil, let records = records {
                self.listTalks = records;
                
                self.listTalks.indices.forEach{ index in
                    // Get the list of speaker ids
                    let speakerIds = self.listTalks[index].fields.speakers;
                    
                    // Ensure there are speakers
                    guard let speakerIds = speakerIds else {
                        return
                    }
            
                    // If there are speakers, resolve their references
                    self.talkSpeakersMap[self.listTalks[index].id] = []
                    self.resolveSpeakerReferences(speakerIds: speakerIds, talkRecord: self.listTalks[index])
                }
            }
            else {
                self.errorMessage = error.errorMessage ?? "No error message"
                self.httpError = error.errorType ?? .generic
            }
            
            self.verifyIfLoaded();
        }
    }
    
    private func resolveSpeakerReferences(speakerIds: [String], talkRecord: APIRecord<Talk>){
        let speakerUrl = "https://api.airtable.com/v0/appLxCaCuYWnjaSKB/%F0%9F%8E%A4%20Speakers/"
        
        speakerIds.forEach {speakerId in
            DataSource.getOne(url: speakerUrl + speakerId){ (error: (errorType: HttpError?, errorMessage: String?), record: APIRecord<Speaker>?) in
                DispatchQueue.main.async {
                    if error.errorType == nil, error.errorMessage == nil, let speaker = record {
                        // Save the speaker name associated with the talk id
                        self.talkSpeakersMap[talkRecord.id]?.append(speaker.fields.name)
                    }
                    else {
                        self.errorMessage = error.errorMessage ?? "No error message"
                        self.httpError = error.errorType ?? .generic
                    }
                    
                    self.verifyIfLoaded();
                }
            }
        }
    }
    
    private func setLoading(){
        loaded = false
        talkSpeakersMap = [:]
        errorMessage = nil
        httpError = nil
    }
    
    private func verifyIfLoaded(){
        if (errorMessage != nil || httpError != nil){
            loaded = true
            return
        }
        
        // Check if, for each talk, there are as many speaker name as there are speaker refences
        // If the numbers don't match, then we haven't resolved all names yet
        var notLoadedYet = false // Use this to return a value from the forEach
        listTalks.forEach{ record in
            if (record.fields.speakers != nil && record.fields.speakers?.count != talkSpeakersMap[record.id]?.count) {
                notLoadedYet = true
            }
        }
        if (notLoadedYet){
            loaded = false
            return
        }
        
        // Once all references have been resolved, copy them into the talks instead of the references
        for (index, record) in listTalks.enumerated() {
            listTalks[index].fields.speakers = talkSpeakersMap[record.id]?.sorted() // Sort the names so the order doesn't depend on the response order
        }
        
        // When all the data is loaded, paste the talk speakers in the right place
        loaded = true
    }
}
