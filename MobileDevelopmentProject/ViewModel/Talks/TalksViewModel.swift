//
//  TalksViewModel.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import Foundation

class TalksViewModel: ObservableObject {
    private let bearerToken = "keymaCPSexfxC2hF9"
    
    @Published var loaded = false
    @Published var httpError: HttpError? = nil
    @Published var errorMessage: String? = nil
    @Published var listTalks: [TalkRecord] = []
    
    func fetchTalks() -> Void {
        // Indicate that we are loading the talks
        self.loaded = false
        
        let url = URL(string: "https://api.airtable.com/v0/appLxCaCuYWnjaSKB/%F0%9F%93%86%20Schedule")!
               
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 1000

        // Add bearer token for authentication
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                self.saveCallResult(error: (.generic, error?.localizedDescription ?? "An error occured"), records: nil)
                return
            }
            
            guard let responseHttp = response as? HTTPURLResponse else {
                self.saveCallResult(error: (.http, "Not an HTTP response"), records: nil)
                return
            }
            
            guard responseHttp.statusCode == 200 else {
                self.saveCallResult(error: (.statusCode, String(responseHttp.statusCode)), records: nil)
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            guard let response = try? decoder.decode(TalkAPIResponse.self, from: data) else {
                self.saveCallResult(error: (.parsing, "Response was not a valid JSON"), records: nil)
                return
            }
            
            self.saveCallResult(error: (nil, nil), records: response.records)
        }.resume()
    }
    
    private func saveCallResult(error: (errorType: HttpError?, errorMessage: String?), records: [TalkRecord]?) -> Void {
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
