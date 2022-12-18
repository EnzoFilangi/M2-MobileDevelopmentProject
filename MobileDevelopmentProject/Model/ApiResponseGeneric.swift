//
//  ApiResponseGeneric.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 15/12/2022.
//

import Foundation

/**
 Top-level object definition for AirTable API responses
 */
struct APIResponse<T : Codable>: Codable {
    var records: [APIRecord<T>]
}

/**
 Objects of type T returned from AirTable's API are encapsulated in a Record object.
 This is a container for T
 */
struct APIRecord<T : Codable>: Codable {
    let id: String
    let createdTime: Date
    var fields: T
}
