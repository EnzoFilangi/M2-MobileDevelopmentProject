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
    
    static func get<EntityType : Codable>(url: String, callback: @escaping ((errorType: HttpError?, errorMessage: String?), [APIRecord<EntityType>]?) -> Void) -> Void {
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
            guard let response = try? decoder.decode(APIResponse<EntityType>.self, from: data) else {
                callback((.parsing, "Response was not a valid JSON"), nil)
                return
            }
            
            callback((nil, nil), response.records)
        }.resume()
    }
}
