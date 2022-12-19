//
//  TimeTravelViewModel.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 19/12/2022.
//

import Foundation

class ObservableDate: ObservableObject {
    @Published var date = Date.now
}
