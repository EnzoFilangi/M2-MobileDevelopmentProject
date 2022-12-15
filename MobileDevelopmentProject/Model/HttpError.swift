//
//  HttpError.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 15/12/2022.
//

import Foundation

enum HttpError : Error {
    case generic
    case http
    case statusCode
    case parsing
}
