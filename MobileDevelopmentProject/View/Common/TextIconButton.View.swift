//
//  TextIconButton.View.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 18/12/2022.
//

import SwiftUI

struct TextIconButton: View {
    
    let iconName : String
    let title : String
    let action : () -> Void
    
    init(iconName: String, title: String, action: @escaping () -> Void) {
        self.iconName = iconName
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button(action: action){
            VStack {
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                Text(title)
                    .font(.caption)
            }
        }
        .foregroundColor(.blue)
        .frame(width: 80, height: 60)
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(.gray, lineWidth: 1)
        )
    }
}

struct TextIconButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextIconButton(iconName: "message.fill", title: "message"){}
            TextIconButton(iconName: "phone.fill", title: "call"){}
            TextIconButton(iconName: "envelope.fill", title: "e-mail"){}
        }
        
    }
}
