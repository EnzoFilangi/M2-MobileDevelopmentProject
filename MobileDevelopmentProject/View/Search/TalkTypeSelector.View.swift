//
//  TalkTypeSelector.View.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 19/12/2022.
//

import SwiftUI

struct TalkTypeSelector: View {
    
    @ObservedObject var data : SelectedTalkTypeViewModel
    
    private func isTypeSelected(_ type: String) -> Bool{
        return data.selectedTypes.contains(type)
    }
    
    private func flipSelectionFactory(type: String) -> () -> Void {
        return {
            if(isTypeSelected(type)){
                data.selectedTypes.removeAll{selectedType in selectedType == type}
            } else {
                data.selectedTypes.append(type)
            }
        }
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(data.possibleTypes, id: \.self){ type in
                    Button(action: flipSelectionFactory(type: type)){
                        // Display the color only if the type is selected or if there are no selected types
                        if(isTypeSelected(type) || data.selectedTypes.count == 0){
                            ColoredTextPill(text: type)
                        } else {
                            ColoredTextPill(text: type, backgroundColor: .gray)
                        }
                    }
                }
            }
            .padding()
        }
        .frame(height: 30)
    }
}

struct TalkTypeSelector_Previews: PreviewProvider {
    static var previews: some View {
        return TalkTypeSelector(data: SelectedTalkTypeViewModel(possibleTypes: ["Panel", "Keynote", "Workshop", "Meal", "Breakout session", "Networking", "Other"]))
    }
}
