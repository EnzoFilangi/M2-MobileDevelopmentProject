//
//  TalkTypePill.View.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 16/12/2022.
//

import SwiftUI

struct ColoredTextPill: View {
    var text : String
    var backgroundColor : Color
    var foregroundColor : Color
    var font : Font
    
    init(text: String) {
        self.init(text: text, backgroundColor: TalkTypeColor.get(text), foregroundColor: .black, font: .caption)
    }
    
    init(text: String, backgroundColor: Color){
        self.init(text: text, backgroundColor: backgroundColor, foregroundColor: .black, font: .caption)
    }
    
    init(text: String, backgroundColor: Color, foregroundColor: Color){
        self.init(text: text, backgroundColor: backgroundColor, foregroundColor: foregroundColor, font: .caption)
    }
    
    init(text: String, backgroundColor: Color, foregroundColor: Color = .black, font: Font){
        self.text = text
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.font = font
    }
    
    var body: some View {
        Text(text)
            .font(font)
            .foregroundColor(self.foregroundColor)
            .padding([.top, .bottom], 5)
            .padding([.leading, .trailing], 15)
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}

struct TalkTypePill_View_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VStack {
                ColoredTextPill(text: "Panel")
                ColoredTextPill(text: "Keynote")
                ColoredTextPill(text: "Workshop")
                ColoredTextPill(text: "Meal")
                ColoredTextPill(text: "Breakout session")
                ColoredTextPill(text: "Networking")
                ColoredTextPill(text: "Other")
            }
            Divider()
            ColoredTextPill(text: "Other but in red", backgroundColor: .red)
            Divider()
            ColoredTextPill(text: "Other but in red and white", backgroundColor: .red, foregroundColor: .white)
            Divider()
            ColoredTextPill(text: "Other but in red and big", backgroundColor: .red, font: .title)
        }
    }
}
