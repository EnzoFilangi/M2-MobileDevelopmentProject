//
//  TalkModel.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import Foundation
import SwiftUI

struct Talk: Codable {
    let location, activity, type: String
    let start, end: Date
    let speakers: [String]?

    enum CodingKeys: String, CodingKey {
        case end = "End"
        case activity = "Activity"
        case type = "Type"
        case speakers = "Speaker(s)"
        case start = "Start"
        case location = "Location"
    }
}

/**
 Lookup table for the colors associated to event types 
 */
struct TalkTypeColor {
    static public func get(_ eventType: String) -> Color {
        switch(eventType){
        case "Panel":
            return Color(red: 165/255, green: 198/255, blue: 250/255)
        case "Keynote":
            return Color(red: 243/255, green: 173/255, blue: 136/255)
        case "Workshop":
            return Color(red: 236/255, green: 161/255, blue: 222/255)
        case "Meal":
            return Color(red: 249/255, green: 216/255, blue: 126/255)
        case "Breakout session":
            return Color(red: 200/255, green: 177/255, blue: 250/255)
        case "Networking":
            return Color(red: 141/255, green: 219/255, blue: 196/255)
        default:
            return Color(white: 0.75)
        }
    }
}
