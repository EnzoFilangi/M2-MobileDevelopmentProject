//
//  TopTabBarView.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import SwiftUI

struct TopTabBar<Content: View>: View {
    @State var tabIndex = 0

    var titles : [String]
    var content : [Content]
    
    init(titles: [String], _ content: Content...) {
        self.titles = titles
        self.content = content
    }
    
    var body: some View {
        VStack(spacing:0){
            TopTabBarButtonsContainer(tabIndex: $tabIndex, titles: self.titles)
            content[tabIndex]
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct TopTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopTabBar(
            titles: ["First tab", "Second tab"],
            Text("1"),
            Text("2")
        )
    }
}
