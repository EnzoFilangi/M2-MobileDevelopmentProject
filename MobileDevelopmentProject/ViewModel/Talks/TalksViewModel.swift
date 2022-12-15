//
//  TalksViewModel.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import Foundation

class TalksViewModel: ObservableObject {
    
    /// Used to temporarily store the resolved speakers to then be able to map them to the right talk
    private var talkSpeakersMap: [String: [String]] = [:]
    
    @Published var loaded = false
    @Published var httpError: HttpError? = nil
    @Published var errorMessage: String? = nil
    @Published var listTalks: [APIRecord<Talk>] = []
    
    /**
     Triggers the process of fetching the list of talks and resolving the references it contains
     */
    func fetchTalks() -> Void {
        resetData()
        
        // Get all talks, sorted ascending on the "Start" column
        let url = "https://api.airtable.com/v0/appLxCaCuYWnjaSKB/%F0%9F%93%86%20Schedule?sort%5B0%5D%5Bfield%5D=Start"
               
        DataSource.get(url: url, callback: self.handleTalksResponse)
    }
    
    /**
     Saves the returned Talks in the class variables and, for each of them, triggers the process of resolving its speaker references
     */
    private func handleTalksResponse(error: (errorType: HttpError?, errorMessage: String?), records: [APIRecord<Talk>]?) {
        DispatchQueue.main.async {
            guard error.errorType == nil, error.errorMessage == nil, let records = records else {
                self.setErrorState(error: error)
                return
            }
            
            self.listTalks = records;
            
            self.listTalks.indices.forEach{ index in
                // Get the list of speaker ids
                let speakerIds = self.listTalks[index].fields.speakers;
                
                // Ensure there are speakers
                guard let speakerIds = speakerIds else {
                    return
                }
        
                // If there are speakers, resolve their references
                self.talkSpeakersMap[self.listTalks[index].id] = [] // Prepare the speakerId -> speakerName map
                self.resolveSpeakerReferences(speakerIds: speakerIds, talkRecord: self.listTalks[index])
            }
            
            self.verifyIfLoaded();
        }
    }
    
    private func resolveSpeakerReferences(speakerIds: [String], talkRecord: APIRecord<Talk>){
        let speakerUrl = "https://api.airtable.com/v0/appLxCaCuYWnjaSKB/%F0%9F%8E%A4%20Speakers/"
        
        speakerIds.forEach {speakerId in
            DataSource.getOne(url: speakerUrl + speakerId){ (error: (errorType: HttpError?, errorMessage: String?), record: APIRecord<Speaker>?) in
                DispatchQueue.main.async {
                    guard error.errorType == nil, error.errorMessage == nil, let speaker = record else {
                        self.setErrorState(error: error)
                        return
                    }
                    
                    // Save the speaker name associated with the talk id
                    self.talkSpeakersMap[talkRecord.id]?.append(speaker.fields.name)
                    self.verifyIfLoaded();
                }
            }
        }
    }
    
    private func resetData(){
        loaded = false
        talkSpeakersMap = [:]
        errorMessage = nil
        httpError = nil
    }
    
    private func setErrorState(error: (errorType: HttpError?, errorMessage: String?)){
        errorMessage = error.errorMessage ?? "No error message"
        httpError = error.errorType ?? .generic
        loaded = true;
    }
    
    private func verifyIfLoaded(){
        // If we are in an error state, don't even verify that some things have loaded
        guard errorMessage == nil, httpError == nil else {
            return
        }
        
        if (!isSpeakerMapFull()){
            loaded = false
            return
        }
        
        // Once all references have been resolved, copy them into the talks instead of the references
        applySpeakerMap()
        
        // When all the data is loaded, paste the talk speakers in the right place
        loaded = true
    }
    
    private func isSpeakerMapFull() -> Bool{
        // Check if, for each talk, there are as many speaker name as there are speaker refences
        // If the numbers don't match, then we haven't resolved all names yet
        var complete = true // Use this to return a value from the forEach
        listTalks.forEach{ record in
            if (record.fields.speakers != nil && record.fields.speakers?.count != talkSpeakersMap[record.id]?.count) {
                complete = false
            }
        }
        return complete
    }
    
    private func applySpeakerMap(){
        for (index, record) in listTalks.enumerated() {
            listTalks[index].fields.speakers = talkSpeakersMap[record.id]?.sorted() // Sort the names so the order doesn't depend on the response order
        }
    }
}
