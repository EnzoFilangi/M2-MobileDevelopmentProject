//
//  TalkTypeSelector.ViewModel.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 19/12/2022.
//

import Foundation

class SelectedTalkTypeViewModel : ObservableObject {
    @Published var possibleTypes : [String]
    @Published var selectedTypes : [String] = []
    
    init(possibleTypes: [String]) {
        self.possibleTypes = possibleTypes
    }
    
    func isTalkTypeSelected(talkType: String) -> Bool {
        return selectedTypes.count == 0 || selectedTypes.contains(talkType)
    }
}
