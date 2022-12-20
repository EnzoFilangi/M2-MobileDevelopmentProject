//
//  Speakers.ViewModel.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 18/12/2022.
//

import Foundation

class SpeakersViewModel : ObservableObject {
    @Published var httpError: HttpError? = nil
    @Published var errorMessage: String? = nil
    @Published var listSpeakers: [APIRecord<Speaker>] = []
    
    init() {
        fetchSpeakers()
    }
    
    func fetchSpeakers(){
        prepareFetch()
        
        // Get all speakers
        let url = "https://api.airtable.com/v0/appLxCaCuYWnjaSKB/%F0%9F%8E%A4%20Speakers"
        
        DataSource.get(url: url, callback: self.handleSpeakersResponse)
    }
    
    /**
     Prepares the class for a fetch operation by resetting any error and temporary variables
     */
    private func prepareFetch() {
        errorMessage = nil
        httpError = nil
        // Do not erase listSpeakers to leave a cache for the UI while the operation is in progress
    }
    
    private func handleSpeakersResponse(error: (errorType: HttpError?, errorMessage: String?), records: [APIRecord<Speaker>]?){
        DispatchQueue.main.async {
            guard error.errorType == nil, error.errorMessage == nil, let records = records else {
                self.handleError(error: error)
                return
            }
            
            self.listSpeakers = records 
        }
    }
    
    /**
     Decomposes the tuple given as parameters into class fields
     */
    private func handleError(error: (errorType: HttpError?, errorMessage: String?)){
        errorMessage = error.errorMessage ?? "No error message"
        httpError = error.errorType ?? .generic
    }
}
