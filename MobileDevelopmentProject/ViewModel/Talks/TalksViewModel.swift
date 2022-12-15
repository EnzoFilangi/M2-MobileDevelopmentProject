//
//  TalksViewModel.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import Foundation

class TalksViewModel: ObservableObject {
    
    private var speakerIdToSpeakerNameMap: [String: String] = [:]
    private var unresolvedTalks: [APIRecord<Talk>] = []
    private var fetching = false;

    @Published var httpError: HttpError? = nil
    @Published var errorMessage: String? = nil
    @Published var listTalks: [APIRecord<Talk>] = []
    
    init(){
        fetchTalks()
    }
    
    /**
     Triggers the process of fetching the list of talks
     */
    func fetchTalks() {
        // Prevent spam
        guard !fetching else {
            return
        }
        
        prepareFetch()
        
        // Get all talks, sorted ascending on the "Start" column
        let url = "https://api.airtable.com/v0/appLxCaCuYWnjaSKB/%F0%9F%93%86%20Schedule?sort%5B0%5D%5Bfield%5D=Start"
               
        DataSource.get(url: url, callback: self.handleTalksResponse)
    }
    
    /**
     Prepares the class for a fetch operation by resetting any error and temporary variables
     */
    private func prepareFetch() {
        fetching = true
        speakerIdToSpeakerNameMap = [:]
        unresolvedTalks = []
        errorMessage = nil
        httpError = nil
        // Do not erase listTalks to leave a cache for the UI while the operation is in progress
    }
    
    /**
     Saves the list of Talk returned from the API and triggers the process of resolving their speaker references
     */
    private func handleTalksResponse(error: (errorType: HttpError?, errorMessage: String?), records: [APIRecord<Talk>]?) {
        DispatchQueue.main.async {
            guard error.errorType == nil, error.errorMessage == nil, let records = records else {
                self.handleError(error: error)
                return
            }
            
            self.unresolvedTalks = records
            self.resolveSpeakerNames()
        }
    }
    
    /**
     Fetches the speaker names from the API using their ids. Whenever a new name is fetched, saves it and tries to apply the map
     */
    private func resolveSpeakerNames(){
        // Get a list of every unique speaker id
        speakerIdToSpeakerNameMap = buildEmptySpeakerMap(records: unresolvedTalks)
        
        // Fetch each unique speaker and save their name
        let speakerUrl = "https://api.airtable.com/v0/appLxCaCuYWnjaSKB/%F0%9F%8E%A4%20Speakers/"
        speakerIdToSpeakerNameMap.keys.forEach { speakerId in
            DataSource.getOne(url: speakerUrl + speakerId){ (error: (errorType: HttpError?, errorMessage: String?), record: APIRecord<Speaker>?) in
                DispatchQueue.main.async {
                    guard error.errorType == nil, error.errorMessage == nil, let speaker = record else {
                        self.handleError(error: error)
                        return
                    }
                    
                    // Save the speaker name associated with the talk id
                    self.speakerIdToSpeakerNameMap[speakerId] = speaker.fields.name
                    self.tryApplySpeakerMap() // Since we don't know which callback will happen last, always check if we can apply the map
                }
            }
        }
    }
    
    /**
     Builds the foundation of the speaker id to speaker name translation map
     
     Returns a [String:String] map where the keys are all the existing speaker ids, and the values are all empty strings that should be filled later on
     */
    private func buildEmptySpeakerMap(records: [APIRecord<Talk>]) -> [String: String] {
        var map : [String: String] = [:]
        records.forEach{record in
            record.fields.speakers?.forEach{speaker in
                map[speaker] = "" // Can't use nil otherwise the key is not added to the map
            }
        }
        return map
    }
    
    /**
     If the speaker list is full, converts each talk's list of speaker ids to a list of speaker names
     */
    private func tryApplySpeakerMap(){
        // If we are in an error state, don't even verify that some things have loaded
        guard errorMessage == nil, httpError == nil else {
            return
        }
        
        guard isSpeakerMapFull() else {
            return
        }
        
        // Re-enable refresh
        fetching = false
        
        // Once all references have been resolved, copy them into the talks in lieu of the references
        // For each talk, translate each list of speaker ids into a list of speaker names and asign it to the talk's speakers
        listTalks = unresolvedTalks.map { talk in
            var talk = talk // Allow mutating talk
            talk.fields.speakers = talk.fields.speakers?.map{speakerIdToSpeakerNameMap[$0] ?? ""}
            return talk
        }
    }
    
    /**
     Returns false if {speakerIdToSpeakerNameMap} still contains empty values, true otherwise
     */
    private func isSpeakerMapFull() -> Bool {
        // Check if all the speaker ids are associated with a speaker name
        for (_,value) in speakerIdToSpeakerNameMap {
            if (value == ""){
                return false
            }
        }
        return true
    }
    
    /**
     Decomposes the tuple given as parameters into class fields
     
     Indeed, if any error occurs, we can discard further results as we should display an error message to the user.
     */
    private func handleError(error: (errorType: HttpError?, errorMessage: String?)){
        errorMessage = error.errorMessage ?? "No error message"
        httpError = error.errorType ?? .generic
    }
}
