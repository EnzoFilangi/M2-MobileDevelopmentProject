//
//  DataSource.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 15/12/2022.
//

import Foundation

class DataSource {
    static private let bearerToken = "keymaCPSexfxC2hF9"
    
    static private func createRequest(urlStr: String) -> URLRequest {
        let url = URL(string: urlStr)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 1000
        
        // Add bearer token for authentication
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    /**
     Sends an HTTP GET request to the provided {url}, and calls {callback} with the eventual errors in a tuple and a list of APIRecord
     
     Use this when fetching multiple records at once
     */
    static func get<EntityType : Codable>(url: String, callback: @escaping ((errorType: HttpError?, errorMessage: String?), [APIRecord<EntityType>]?) -> Void) -> Void {
        // Since the result of routes with
        executeGetRequest(url: url){ (error: (errorType: HttpError?, errorMessage: String?), response: APIResponse<EntityType>?) in
            callback(error, response?.records)
        }
    }
    
    /**
     Sends an HTTP GET request to the provided {url}, and calls {callback} with the eventual errors in a tuple and one APIRecord
     
     Use this when fetching a single record using its id
     */
    static func getOne<EntityType: Codable>(url: String, callback: @escaping ((errorType: HttpError?, errorMessage: String?), APIRecord<EntityType>?) -> Void) -> Void {
        executeGetRequest(url: url, callback: callback)
    }
    
    private static func executeGetRequest<JSONResponseType: Codable>(url: String, callback: @escaping ((errorType: HttpError?, errorMessage: String?), JSONResponseType?) -> Void) -> Void {
        URLSession(configuration: .default).dataTask(with: createRequest(urlStr: url)) { (data, response, error) in
            guard let data = data, error == nil else {
                callback((.generic, error?.localizedDescription ?? "An error occured"), nil)
                return
            }
            
            guard let responseHttp = response as? HTTPURLResponse else {
                callback((.http, "Not an HTTP response"), nil)
                return
            }
            
            guard  responseHttp.statusCode == 200 else {
                callback((.statusCode, String(responseHttp.statusCode)), nil)
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            guard let response = try? decoder.decode(JSONResponseType.self, from: data) else {
                callback((.parsing, "Response was not a valid JSON"), nil)
                return
            }
            
            callback((nil, nil), response)
        }.resume()
    }
}
