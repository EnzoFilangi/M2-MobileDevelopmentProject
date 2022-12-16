//
//  SpeakerModel.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 15/12/2022.
//

import Foundation

struct Speaker: Codable {
    let name: String
    let speakingAt: [String]
    let role, company, phone, email: String

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case speakingAt = "Speaking at"
        case role = "Role"
        case company = "Company"
        case phone = "Phone"
        case email = "Email"
    }
}
