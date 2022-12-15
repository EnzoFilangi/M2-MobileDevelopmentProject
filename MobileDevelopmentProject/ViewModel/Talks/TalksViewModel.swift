//
//  TalksViewModel.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import Foundation

class TalksViewModel: ObservableObject {
    
    @Published var loaded = false
    @Published var httpError: HttpError? = nil
    @Published var errorMessage: String? = nil
    @Published var listTalks: [APIRecord<Talk>] = []
    
    func fetchTalks() -> Void {
        // Indicate that we are loading the talks
        self.loaded = false
        
        // Get all talks, sorted ascending on the "Start" column
        let url = "https://api.airtable.com/v0/appLxCaCuYWnjaSKB/%F0%9F%93%86%20Schedule?sort%5B0%5D%5Bfield%5D=Start"
               
        DataSource.get(url: url, callback: self.saveCallResult)
    }
    
    private func saveCallResult(error: (errorType: HttpError?, errorMessage: String?), records: [APIRecord<Talk>]?) -> Void {
        DispatchQueue.main.async {
            if error.errorType == nil, error.errorMessage == nil, let records = records {
                self.listTalks = records;
            }
            else {
                self.errorMessage = error.errorMessage ?? "No error message"
                self.httpError = error.errorType ?? .generic
            }
            
            self.loaded = true; // Set loaded to true at the very end of the function to trigger the view change after all variables are set
        }
    }
}
