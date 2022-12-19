//
//  ErrorMessage.View.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 19/12/2022.
//

import SwiftUI

struct ErrorMessage: View {
    
    let errorText : String
    
    init(_ errorText: String) {
        self.errorText = errorText
    }
    
    var body: some View {
        VStack {
            Text("😰")
                .font(.system(size: 100))
            Text(errorText)
                .font(.title3)
                .foregroundColor(.main)
                .multilineTextAlignment(.center)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity
        )
        .padding()
    }
}

struct ErrorMessage_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessage("The list of talks couldn't be fetched, please check your internet connection.")
    }
}
